require 'net/http'
require 'fingerbank_client/exception'

class Fingerbank
  module Upstream
    def update
      http = Net::HTTP.new("fingerbank.inverse.ca", 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      resp = http.get("/api/v1/download?key=#{self.key}")

      raise FingerbankError.new("Communication error"), "Couldn't download databse : #{resp.body}" if resp.code != '200'

      file = File.new("fingerbank.sqlite", "w:ASCII-8BIT")
      file.write(resp.body)
      file.close

      return true
    end

    def interrogate(user_agent)
      http = Net::HTTP.new("fingerbank.inverse.ca", 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      url = "/api/v1/combinations/interrogate?key=#{self.key}"
      require 'cgi'
      user_agent = CGI.escape(user_agent)
      url = "#{url}&user_agent=#{user_agent}"
      resp = http.get(url)

      return nil if resp.code == '404'
      raise FingerbankError.new("Communication error"), "Couldn't contact upstream : #{resp.body}" if resp.code != '200'

      require 'json'
      data = JSON.parse(resp.body) 

      return data
    end
  end
end
