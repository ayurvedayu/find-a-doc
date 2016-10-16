require 'securerandom'
require 'sms/bhash_sender'

class Spree::Verification < ActiveRecord::Base
  attr_accessor :entered_token
  belongs_to :verifiable, polymorphic: true

  enum status: [:active, :completed, :deleted]
  after_create :send_message

  before_create :generate_token
  before_update :check_token, if: "entered_token"
  after_update :run_verifiable_callbacks, if: "completed?"

  validates_presence_of :phone, :verifiable, :token, :status

  def run_verifiable_callbacks
    verifiable.save!
  end

  def check_token 
    if entered_token == token
      self.status = 'completed'
    else
      false
    end
  end
  def generate_token
    self.token = SecureRandom.random_number.to_s.split('')[4..7].join
  end

  def message 
    "#{token} - verification code for Ayurvedayu."
  end

  def send_message
    # byebug
    res = BHash::Message.send(phone, message)

    logger.debug BHash::API.new phone, message
    logger.debug res
  end
end

