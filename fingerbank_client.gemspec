$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fingerbank_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fingerbank_client"
  s.version     = FingerbankClient::VERSION
  s.authors     = ["Julien Semaan"]
  s.email       = ["jul.semaan@gmail.com"]
  s.homepage    = "https://github.com/julsemaan/fingerbank_client"
  s.summary     = "Provides an interface to query Fingerbank with user agents."
  s.description = "The Fingerbank client is a ruby client that can accuratly determine what kind of device is using your application based on the client user agent.
It uses the data collected by the Fingerbank project and it's public API to allow the discovery of more than 5000 devices including detailed information of most of the Android devices.."
  s.license     = "GNU"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
#  s.test_files = Dir["test/**/*"]

end
