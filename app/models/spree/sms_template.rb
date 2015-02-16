class Spree::SMSTemplate
  # include ActiveRecord::Model

  def self.doctor_pending_sms apt
    "#{apt.name.titleize} (#{apt.phone}) asked for appointment at #{apt.scheduled_at}. Confirm it in your profile at Ayurvedayu."
  end

  def self.doctor_sms apt
    "#{apt.name.titleize} (#{apt.phone}) scheduled appointment at #{apt.scheduled_at}. Ayurvedayu."
  end

  def self.user_sms apt
    "Appointment scheduled at #{apt.scheduled_at} to #{apt.doctor_employment.doctor.name} (#{apt.doctor_employment.doctor.phone}) at #{apt.doctor_employment.clinic.full_address}. Ayurvedayu."
  end

  def self.user_cancel_sms apt
    "#{apt.doctor_employment.doctor.name_with_dr} canceled your appointment at #{apt.scheduled_at}, #{apt.doctor_employment.clinic.full_address}. Ayurvedayu."
  end

  def self.doctor_cancel_sms apt
    "#{apt.name} canceled their appointment at #{apt.scheduled_at}. Ayurvedayu"
  end
end