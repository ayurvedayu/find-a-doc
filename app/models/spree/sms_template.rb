class Spree::SMSTemplate
  # include ActiveRecord::Model

  def self.doctor_pending_sms apt
    "#{apt.name.titleize} (#{apt.phone}) asked for appointment at #{apt.scheduled_at}. Confirm it in your profile at Ayurvedayu."
  end

  def self.doctor_sms apt
    "#{apt.name.titleize} (#{apt.phone}) scheduled appointment at #{apt.scheduled_at} in #{apt.full_address}. Ayurvedayu."
  end

  def self.user_sms apt
    "Appointment scheduled at #{apt.scheduled_at} to #{apt.appointmentable} (#{apt.appointmentable.phone}) at #{apt.full_address}. Ayurvedayu."
  end

  def self.user_cancel_sms apt
    "Your appointment to #{apt.appointmentable} at #{apt.scheduled_at}, #{apt.full_address} is canceled. Ayurvedayu."
  end

  def self.doctor_cancel_sms apt
    "#{apt.name} canceled their appointment at #{apt.scheduled_at}. Ayurvedayu"
  end
end