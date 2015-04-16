require 'fingerbank_client/device'

class Fingerbank
  module Lookup
    def _lookup(user_agent)
      begin
        device = Device.lookup_in_local(user_agent)
        return device unless device.nil?
      rescue Exception => e
        Fingerbank.logger.warn "Can't lookup device in local database"
        Fingerbank.logger.error e.message
      end

      device = lookup_in_upstream user_agent
      return device
    end

    def lookup(user_agent)
      if defined?(::Rails)
        Rails.cache.fetch(user_agent, :expires_in => 2.hour) do
          _lookup(user_agent)
        end
      else
        return _lookup(user_agent)
      end
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
