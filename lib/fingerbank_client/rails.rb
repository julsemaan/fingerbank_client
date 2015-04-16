require "rails/railtie"
require "fingerbank_client/action_controller"
require "fingerbank_client/middleware"

class Browser
  class Railtie < Rails::Railtie
    initializer "fingerbank" do
      ::ActionController::Base.send :include, FingerbankClient::ActionController
    end

    rake_tasks do
      load "tasks/fingerbank_client_tasks.rake"
      FingerbankClient::Middleware::Context.send :include
    end
  end
end
