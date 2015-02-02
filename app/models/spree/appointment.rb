class Spree::Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor_employment
  has_one :review
  accepts_nested_attributes_for :review

  validates_uniqueness_of :scheduled_at, scope: :doctor_employment_id

  enum status: [ :initiated, :completed, :canceled]
  enum payment: [ :cash, :online ]

  default_scope { order(status: :asc) }

  def scheduled_at
  end
end
