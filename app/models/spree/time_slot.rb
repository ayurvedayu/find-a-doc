class Spree::TimeSlot

  def self.all

    ret = []
    0.upto(23) do |hour|
      ['00','30'].each do |minute|
        ret << [ hour.to_s.rjust(2, '0'), minute].join(':')
      end
    end

    ret
  end
end