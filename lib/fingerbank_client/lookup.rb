require 'fingerbank_client/device'

class Fingerbank
  module Lookup
    def _lookup(user_agent)
      begin
        device = Device.lookup_in_local(user_agent)
        return device unless device.nil?
      rescue Exception => e
        Fingerbank.logger.warn "Fingerbank : Can't lookup device in local database (#{e.message})"
      end

      device = lookup_in_upstream user_agent
      return device
    end

    def lookup(user_agent)
      begin
        if defined?(Rails)
          Rails.cache.fetch(user_agent, :expires_in => 2.hour) do
            _lookup(user_agent)
          end
        end
      rescue NameError => e
        unless e.message == "uninitialized constant RAILS_CACHE"
          raise e
        end
      end
      return _lookup(user_agent)
    end

    def lookup_in_upstream(user_agent)
      data = self.interrogate(user_agent)
      return nil unless data
      name = data['device']['name']
      parents = data['device']['parents'].map{|parent| parent['name']}
      return Device.new(:name => name, :parents => parents, :version => data['version'])
    end
  end
end
