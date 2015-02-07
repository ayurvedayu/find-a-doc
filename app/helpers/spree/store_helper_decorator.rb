Spree::StoreHelper.module_eval do
  def day_name day_number
    Date::DAYNAMES[day_number]
  end
  
  def human_timings timings
    raw(sequence_of_days(timings).map do |s|
      day_abbr_name(s.first.day) + ("&ndash;#{day_abbr_name(s.last.day)}" if s.size > 1).to_s + "<br>#{s.first.start_time}&mdash;#{s.first.end_time}"
    end.join('<br>'))
  end



  def day_abbr_name day_number
    Date::ABBR_DAYNAMES[day_number]
  end

  private

  def sequence_of_days timings
    arr = []
    seq = []
    t_arr = timings.to_a

    t_arr.each.with_index do |t,i|
      if t.working? and seq.empty?
        seq << t
        next
      end

      if seq.empty? and t.not_working?
        next
      end
      if i == t_arr.size - 1 and t.end_time == seq.last.end_time and t.start_time == seq.last.start_time and t.working?
        seq << t
        arr << seq
        next
      end

      if i != t_arr.size - 1 and t.end_time == seq.last.end_time and t.start_time == seq.last.start_time and t.working?
        seq << t
        next
      end
      arr << seq
      seq = []
      if t.working?
        seq << t
      end
    end
    arr
  end
  
  def r_timings_sequence timings, i
    if timings[i+1] and timings[i].end_time == timings[i+1].end_time and timings[i].start_time == timings[i+1].start_time
      r_timings_sequence(timings, i+1)
    else
      return timings[i].day
    end
  end

end

# alla.working.each_with_index.chunk do |c,i| 
#   if alla.working[i-1] and alla.working[i-1]
#     c.day - alla.working[i-1].day < 2 or alla.working[i+1].day - c.day < 2
#   else 
#     true
#   end
# end.map { |m,p| pp [m, p]}



