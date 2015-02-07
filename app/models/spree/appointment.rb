class Spree::Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor_employment
  has_one :review
  accepts_nested_attributes_for :review

  has_many :verifications, as: :verifiable

  validates_presence_of :scheduled_at, :name, :phone, :address, :status
  validates_presence_of :email, if: "user_id.nil?"
  validates_uniqueness_of :scheduled_at, scope: :doctor_employment_id
  validate :scheduled_at_cannot_be_in_past
  enum status: [ :initiated, :completed, :canceled, :unverified]
  enum payment: [ :cash, :online ]

  default_scope { order(status: :asc) }

  def scheduled_at_time
    scheduled_at.strftime("%R")
  end


  def scheduled_at_cannot_be_in_past

    if scheduled_at.present? and scheduled_at < DateTime.now
      errors.add(:scheduled_at, "can't be in the past")
    end
  end
end
