require 'fingerbank_client/upstream'
require 'fingerbank_client/lookup'
require 'fingerbank_client/rails' if defined?(::Rails)

class Fingerbank
  include Upstream
  include Lookup

  attr_accessor :key

  def initialize(options = {})
    self.key = options[:key]
  end
end

class FingerbankClient < Fingerbank
  def initialize
    options = {:key => ENV['fingerbank_key']}
    super(options) 
  end
end


