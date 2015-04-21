$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fingerbank_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fingerbank_client"
  s.version     = FingerbankClient::VERSION
  s.authors     = ["Julien Semaan"]
  s.email       = ["jul.semaan@gmail.com"]
  s.homepage    = "http://fingerbank.org"
  s.summary     = "Provides an interface to query Fingerbank with user agents."
  s.description = "Add longer description."
  s.license     = "GNU"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

end
