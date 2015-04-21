require 'fingerbank_client/device'

class Fingerbank
  module Lookup
    def _lookup(info)
      user_agent = info[:user_agent]
      begin
        device = Device.lookup_in_local(info)
        return device unless device.nil?
      rescue Exception => e
        Fingerbank.logger.warn "Fingerbank : Can't lookup device in local database (#{e.message})"
      end

      device = lookup_in_upstream info 
      return device
    end

    def lookup(info)
      user_agent = info[:user_agent]
      begin
        if defined?(Rails)
          Rails.cache.fetch(user_agent, :expires_in => 2.hour) do
            _lookup(info)
          end
        end
      rescue NameError => e
        unless e.message == "uninitialized constant RAILS_CACHE"
          raise e
        end
      end
      return _lookup(info)
    end

    def lookup_in_upstream(info)
      user_agent = info[:user_agent]
      data = self.interrogate(user_agent)
      return nil unless data
      name = data['device']['name']
      parents = data['device']['parents'].map{|parent| parent['name']}
      return Device.new(:name => name, :parents => parents, :version => data['version'])
    end
  end
end
