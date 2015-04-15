require 'fingerbank_client/device'

class Fingerbank
  module Lookup
    def lookup(user_agent)
      device = Device.lookup_in_local(user_agent)
      return device unless device.nil?

      device = lookup_in_upstream user_agent
      return device
    end


    def lookup_in_upstream(user_agent)
      data = self.interrogate(user_agent)
      return nil unless data
      name = data['device']['name']
      parents = data['device']['parents'].map{|parent| parent['name']}
      return Device.new(:name => name, :parents => parents)
    end
  end
end
