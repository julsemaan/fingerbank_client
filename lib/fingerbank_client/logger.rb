
require 'logger'

class Fingerbank
  def self.logger
    return defined?(Rails) && defined?(Rails.logger) ? Rails.logger : Logger.new(STDOUT)
  end
end

