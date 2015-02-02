module Spree::AppointmentsHelper
  def current_time_slot
    round_time(30.minutes).strftime("%H:%M")
  end

  def round_time step
    time = Time.now
    Time.at((time.to_f/step).round * step)
  end
end
