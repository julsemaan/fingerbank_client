require 'fingerbank_client/database'
require 'fingerbank_client/device_classes'

class Device
  include Classes

  attr_accessor :parents
  attr_accessor :name
  attr_accessor :version

  def self.lookup_in_local(user_agent)
    db = Database.new

      rs = db.query "SELECT id from user_agent where value=?", user_agent
      user_agent_id=-1
      begin
        user_agent_id = rs.first[0]
      rescue
        return nil
      end

      rs = db.query "SELECT device.id,device.name,device.parent_id,combination.version FROM device join combination on device.id=combination.device_id where combination.user_agent_id=? order by score desc limit 1", user_agent_id
      record = rs.first
      id = record[0]
      name = record[1]
      parent_id = record[2]
      version = record[3]
      parents = []

      until(parent_id.nil?)
        rs = db.query "SELECT device.name,device.parent_id from device where id=?", parent_id
        record = rs.first
        parents << record[0]
        parent_id = record[1]
      end

      Device.new(:name => name, :parents => parents, :version => version)
  end

  def initialize(options = {})
    self.name = options[:name]
    self.parents = options[:parents]
    self.version = options[:version]
  end

  def has_parent?(name)
    self.parents.include?(name)
  end

  def is?(name)
    return true if name == self.name
    return self.has_parent?(name)
  end

end
