require "rails/railtie"
require "fingerbank_client/action_controller"
require "fingerbank_client/middleware"

class FingerbankClient < Fingerbank
  class Railtie < Rails::Railtie
    initializer "fingerbank" do
      ::ActionController::Base.send :include, FingerbankClient::ActionController
    end

    rake_tasks do
      load "tasks/fingerbank_client_tasks.rake"
    end
  end
end
