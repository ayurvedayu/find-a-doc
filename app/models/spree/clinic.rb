class Spree::Clinic < ActiveRecord::Base
  belongs_to :suburb
  accepts_nested_attributes_for :suburb
  
  belongs_to :user
  belongs_to :clinic_type
  has_many :doctors
end
