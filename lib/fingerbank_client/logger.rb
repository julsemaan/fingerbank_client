
require 'logger'

class Fingerbank
  def self.logger
    return defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end
end

