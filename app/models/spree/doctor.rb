class Spree::Doctor < ActiveRecord::Base
  has_many :doctor_employments
  has_many :clinics, through: :doctor_employments
  accepts_nested_attributes_for :doctor_employments
  
  belongs_to :user
  has_and_belongs_to_many :specialties
end
