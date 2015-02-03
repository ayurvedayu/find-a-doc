require 'securerandom'
class Spree::VerificationsController < ApplicationController
  def create
    tkn = SecureRandom.random_number.to_s.split('')[4..7].join
    phone = params[:verification][:phone]
    current_spree_user.verifications.update_all status: 'deleted'

    message = "#{tkn} - verification code for Ayurvedayu."

    res = BHash::Message.send(phone, message)

    logger.debug BHash::API.new phone, message
    logger.debug res

    vrf = current_spree_user.verifications.new token: tkn, status: 'active'

    if vrf.save
      redirect_to spree.account_path, notice: 'Verification code sent to your phone'
    end
  end

  def destroy
  end

  def update
  end

  def complete
    vrf = current_spree_user.verifications.active.last

    if params[:verification][:token].eql? vrf.token
      current_spree_user.update(phone_is_verified: true)
      vrf.update status: 'completed'
      redirect_to spree.account_path, notice: 'Your phone is succesfully verified, thank you.'
    else
      redirect_to spree.account_path, alert: 'Wrong activation code.'
    end
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
