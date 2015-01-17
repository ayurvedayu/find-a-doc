class Spree::Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor_employment
end
