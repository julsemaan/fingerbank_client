require 'fingerbank_client/upstream'
require 'fingerbank_client/lookup'
require 'fingerbank_client/rails' if defined?(::Rails)

class Fingerbank
  include Upstream
  include Lookup

  attr_accessor :key
  attr_accessor :last_error

  def initialize(options = {})
    self.key = options[:key]
    self.last_error = nil
  end
end

class FingerbankClient < Fingerbank
  def initialize
    options = {:key => ENV['fingerbank_key']}
    super(options) 
  end
end


