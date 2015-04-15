require "rails/railtie"
require "fingerbank_client/action_controller"

class Browser
  class Railtie < Rails::Railtie
    initializer "fingerbank" do
      ::ActionController::Base.send :include, FingerbankClient::ActionController
    end
  end
end
