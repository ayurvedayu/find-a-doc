require 'securerandom'

class Spree::Verification < ActiveRecord::Base
  belongs_to :verifiable, polymorphic: true

  enum status: [:active, :completed, :deleted]
  after_create :send_message

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.random_number.to_s.split('')[4..7].join
  end

  def message 
    "#{token} - verification code for Ayurvedayu."
  end

  def send_message
    res = BHash::Message.send(phone, message)

    logger.debug BHash::API.new phone, message
    logger.debug res
  end
end


require 'net/http'

module BHash
  class API
    def initialize to, msg
      raise 'specify sms gateway login and pass in configuration file please' if SpreeFindaDoc.bhash_login.nil?
      @link = "http://bhashsms.com/api/sendmsg.php?user=#{SpreeFindaDoc.bhash_login}&pass=#{SpreeFindaDoc.bhash_pass}&sender=TESTTO&phone=#{CGI::escape(to)}&text=#{CGI::escape(msg)}&priority=ndnd&stype=normal"
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
    end

    def self.send to, msg
      message = new(to, msg)
      message.send
    end

  end
end