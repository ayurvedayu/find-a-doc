class AppointmentMailer < ActionMailer::Base
  # include ActionMailer::DeliverLater::Mixin
  default from: "info@ayurvedayu.com"

  def pending_doctor_email appointment
    @appointment = appointment

    mail(to: @appointment.doctor_employment.doctor.user.email, subject: 'Ayurvedayu: confirm new appointment please')
  end

  def initiated_email_user appointment
    @appointment = appointment
    
    mail(to: @appointment.real_email, subject: 'Ayurvedayu: new appointment scheduled')
  end

  def initiated_email_doctor appointment
    @appointment = appointment
    mail(to: appointment.doctor_employment.doctor.user.email, subject: 'Ayurvedayu: new appointment scheduled')
  end
end
