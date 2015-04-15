# desc "Explaining what the task does"
# task :fingerbank_client do
#   # Task goes here
# end

require 'net/http'
require 'fingerbank_client'

namespace :fingerbank do |ns|
  desc "Update the fingerbank database"
  task :update do
    FingerbankClient.new.update
    puts "Success!"
  end

  desc "Find out the information for a user agent"
  task :lookup, [:user_agent] do |t, args|
    device = FingerbankClient.new.lookup(args[:user_agent])
    puts device.inspect
  end
end
