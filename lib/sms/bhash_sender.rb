require 'net/http'

module BHash
  class API
    def initialize to, msg
      raise 'specify sms gateway login and pass in configuration file please' if SpreeFindaDoc.bhash_login.nil?
      @link = "http://bhashsms.com/api/sendmsg.php?user=#{SpreeFindaDoc.bhash_login}&pass=#{SpreeFindaDoc.bhash_pass}&sender=TESTTO&phone=#{CGI::escape(to.to_s)}&text=#{CGI::escape(msg.to_s)}&priority=ndnd&stype=normal"
    end

    def to_s
      @link
    end
  end

  class Message
    def initialize to, msg
      @api = API.new to, msg
    end

    def send
      uri = URI(@api.to_s)
      res = Net::HTTP.get(uri)
      Rails.logger.debug 'sms send'
      Rails.logger.debug res
    end

    def self.send to, msg
      message = new(to, msg)
      message.send
    end

  end
end