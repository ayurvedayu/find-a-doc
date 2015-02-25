class Spree::TimeSlot
  include ActiveModel::Model

  attr_accessor :slot, :date, :occupied

  # aliases
  def occupied?
    occupied
  end
  def time
    slot
  end


  def datetime
    [date, slot].join(" ")
  end

  def self.slots_of timing
    from = timing.start_in_minutes
    to = timing.end_in_minutes

    return nil if timing.not_working?

    (from..to).step(30).map do |minute|
      time = minute.divmod(60).map { |thing| thing.to_s.rjust(2, '0') }.join(":")
    end
  end

  def self.all_for_doctor( dr_empl, opts )
    date = opts[:date]
    dr_empl = Spree::DoctorEmployment.find(dr_empl) unless dr_empl.respond_to?(:appointments)


    appointments = dr_empl.appointments.where(scheduled_at: date.beginning_of_day..date.end_of_day)
    day = dr_empl.timings.find_by( day: date.wday )

    oc_slots = appointments.initiated.map(&:scheduled_at_time)
    day.slots.to_a.map do |slot|
      occupied = oc_slots.include? slot
      Spree::TimeSlot.new slot: slot, date: date, occupied: occupied
    end
  end
end