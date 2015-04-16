begin
  require 'sqlite3'
rescue LoadError => e
  puts "Cannot load sqlite3 module. Local lookup WILL FAIL !"
  puts e
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
      puts "Exception occurred while selecting in the database"
      self.close
      puts e
      raise e
    end
  end

  def close
    self.db.close if db
  end
end
