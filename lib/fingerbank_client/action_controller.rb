require "action_controller/railtie"

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
      fingerbank.lookup(request.headers["User-Agent"])
    end
  end
end
