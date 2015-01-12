class Spree::Clinic < ActiveRecord::Base
  belongs_to :suburb
  belongs_to :user
  belongs_to :clinic_type
  has_many :doctors
end
