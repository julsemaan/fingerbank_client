require "action_controller/railtie"
require "fingerbank_client/exception"

class FingerbankClient < Fingerbank
  module ActionController
    extend ActiveSupport::Concern

    included do
      helper_method :fingerbank
      helper_method :current_device
    end

    private

    def fingerbank
      @fingerbank_client ||= FingerbankClient.new
    end

    def current_device
      @device = nil
      begin
        @device = fingerbank.lookup(request.headers["User-Agent"])
      rescue FingerbankError => e
        @device = nil
        Fingerbank.logger.error "Fingerbank : Couldn't lookup device. Exception is stored in fingerbank.last_error. Message is : #{e.message}"
        fingerbank.last_error = e
      end
      return @device
    end

  end
end
