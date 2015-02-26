require 'sms/bhash_sender'
class Spree::Appointment < ActiveRecord::Base
  attr_accessor :canceled_by, :recommended
  belongs_to :user
  belongs_to :appointmentable, polymorphic: true
  has_one :review
  accepts_nested_attributes_for :review

  has_many :verifications, as: :verifiable

  validates_presence_of :scheduled_at, :name, :phone, :address, :status
  validates_presence_of :email, if: "user_id.nil?"
  validates_uniqueness_of :scheduled_at, scope: [:appointmentable_id, :appointmentable_type]
  validate :scheduled_at_cannot_be_in_past
  enum status: [ :initiated, :completed, :canceled, :unverified, :pending_doctor]
  enum payment: [ :cash, :online ]

  default_scope { order(status: :asc) }

  after_save :send_initiated_emails
  after_save :send_pending_emails
  after_save :send_canceled_emails
  before_save :auto_confirmable_check, if: "verified? && mint_new?"
  after_save :create_recommendation, if: "recommended"

  # def check_token! verification
  #   if verification[:token] and verification[:id]
  #     vrf = Spree::Verification.find(verification[:id])

  #     errors[:base] <<   unless params[:verification][:token].eql? vrf.token
  #   end
  # end

  def create_recommendation
    if self.doctor_employment
      Spree::Recommendation.create!(user: user, doctor: self.doctor_employment.doctor)
    end
  end
  def auto_confirmable_check
    if appointmentable.auto_confirmable?
      self.status = 'initiated'
    else
      self.status = 'pending_doctor'
    end
  end

  def mint_new?
    unverified? || status.nil?
  end

  def verified?
    verifications.completed.any? || user.try(:phone_is_verified?)
  end

  def to_doctor?
    appointmentable_type == 'Spree::DoctorEmployment'
  end

  # depending on context :)
  def doctor_employment
    appointmentable if to_doctor?
  end

  # depending on context :) use with care
  def clinic
    appointmentable unless to_doctor?
  end

  def scheduled_at_time
    scheduled_at.strftime("%R")
  end


  def scheduled_at_cannot_be_in_past

    if scheduled_at.present? and scheduled_at < DateTime.now
      errors.add(:scheduled_at, "can't be in the past")
    end
  end


  def send_canceled_emails
    if status_changed? and canceled?
      case canceled_by
      when 'doctor'
        AppointmentMailer.cancel_email(email, self).deliver
        BHash::Message.send(phone, Spree::SMSTemplate.user_cancel_sms(self))
      when 'user'
        AppointmentMailer.cancel_email(appointmentable.user.email, self).deliver
        BHash::Message.send(appointmentable.phone, Spree::SMSTemplate.doctor_cancel_sms(self))
      end
    end
  end

  def send_initiated_emails
    if status_changed? and initiated?
      BHash::Message.send(appointmentable.phone, Spree::SMSTemplate.doctor_sms(self))
      BHash::Message.send(phone, Spree::SMSTemplate.user_sms(self))

      AppointmentMailer.initiated_email_doctor(self).deliver
      AppointmentMailer.initiated_email_user(self).deliver
    end
  end

  

  def send_pending_emails
    if status_changed? and pending_doctor?
      BHash::Message.send(appointmentable.phone, Spree::SMSTemplate.doctor_pending_sms(self))

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

  def active_verification
    verifications.where( status: 'active', phone: self.phone).order(created_at: :desc).first_or_create
  end

  def full_address
    appointmentable.try(:full_address) || appointmentable.clinic.full_address
  end

  

  # def after_verification_callback
    # auto_confirmable_check
  # end
end
