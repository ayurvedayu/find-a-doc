class Spree::Experience < ActiveRecord::Base
  default_scope { order(end_year: :desc)}
  belongs_to :doctor

  validate :years_validity

  def years_validity
    if start_year > end_year
      errors[:base] <<  "start year must be before end year"
    end
  end

  def human_end_year
    if end_year == 9999
      'Present'
    else
      end_year
    end
  end
end
