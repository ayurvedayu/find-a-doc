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
  enum status: [ :initiated, :completed, :canceled, :unverified, :pending_doctor]
  enum payment: [ :cash, :online ]

  default_scope { order(status: :asc) }

  after_save :send_initiated_emails
  after_save :send_pending_emails


  def scheduled_at_time
    scheduled_at.strftime("%R")
  end


  def scheduled_at_cannot_be_in_past

    if scheduled_at.present? and scheduled_at < DateTime.now
      errors.add(:scheduled_at, "can't be in the past")
    end
  end

  def doctor_sms
    "#{name.titleize} (#{phone}) scheduled appointment at #{scheduled_at}. Ayurvedayu."
  end

  def user_sms
    "Appointment scheduled at #{scheduled_at} to #{doctor_employment.doctor.name} (#{doctor_employment.doctor.phone}) at #{doctor_employment.clinic.full_address}. Ayurvedayu."
  end


  def send_initiated_emails
    if status_changed? and initiated?
      BHash::Message.send(doctor_employment.doctor.phone, doctor_sms)
      BHash::Message.send(phone, user_sms)

      AppointmentMailer.initiated_email_doctor(self).deliver
      AppointmentMailer.initiated_email_user(self).deliver
    end
  end

  def doctor_pending_sms
    "#{name.titleize} (#{phone}) asked for appointment at #{scheduled_at}. Confirm it in your profile at Ayurvedayu."
  end

  def send_pending_emails
    if status_changed? and pending_doctor?
      BHash::Message.send(doctor_employment.doctor.phone, doctor_pending_sms)

      AppointmentMailer.pending_doctor_email(self).deliver
    end
  end

  def real_email
    if email
      to = email
    elsif user.email
      to = user.email
    else
      ''
    end
  end
end
