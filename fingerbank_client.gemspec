$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fingerbank_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fingerbank_client"
  s.version     = FingerbankClient::VERSION
  s.authors     = ["Julien Semaan"]
  s.email       = ["jul.semaan@gmail.com"]
  s.homepage    = "https://fingerbank.org"
  s.summary     = "Provides an interface to query Fingerbank with user agents."
  s.description = "Add longer description."

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_dependency "sqlite3"
end
