require 'fingerbank_client/logger'

begin
  require 'sqlite3'
rescue LoadError => e
  Fingerbank.logger.warn "Fingerbank : Cannot load sqlite3 module. Local lookup WILL FAIL ! (#{e.message})"
end

class Database
  attr_accessor :db
  def initialize
    self.db = SQLite3::Database.open "fingerbank.sqlite"
  end

  def query(statement, *args)
    begin
      stm = db.prepare statement
      rs = stm.execute(*args) 
    rescue SQLite3::Exception => e 
      Fingerbank.logger.error "Fingerbank : Exception occurred while selecting in the database (#{e.message})"
      self.close
      raise e
    end
  end

  def close
    self.db.close if db
  end
end
