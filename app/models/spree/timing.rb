class Spree::Timing < ActiveRecord::Base
  PERMITTED_ATTRS = [:start_time,:end_time,:day,:is_working_day, :id]
  
  belongs_to :timeslotable, polymorphic: true

  enum is_working_day: [:not_working, :working]

  default_scope { order(id: :asc) }



  def start_in_minutes
    (start_time.to_time.seconds_since_midnight / 60).to_i if start_time
  end

  def end_in_minutes
    (end_time.to_time.seconds_since_midnight / 60).to_i if end_time
  end

  def slots
    Spree::TimeSlot.slots_of self
  end

  # def self.build_a_set_for someone
    # someone.timings.new = 
  # end

  def self.new_for_all_weekdays opts = {}
    (1..6).to_a.push(0).map do |i| 
      new(opts.merge(day: i))
    end
  end
end
