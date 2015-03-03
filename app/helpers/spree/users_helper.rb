module Spree::UsersHelper
  def experience_years(opts = {})
    years = 1970.upto(Date.today.year).map do |y|
      [y,y]
    end
    years << ['Present',9999] unless opts[:start]
    years.reverse
  end
end




