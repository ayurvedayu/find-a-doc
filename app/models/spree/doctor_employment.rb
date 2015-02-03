class Spree::DoctorEmployment < ActiveRecord::Base
  default_scope { where("spree_doctor_employments.status <> ? or spree_doctor_employments.status is null", statuses[:deleted]) }

  belongs_to :doctor
  belongs_to :clinic

  has_many :appointments
  has_many :users, through: :appointments

  validates_numericality_of :consultation_price

  validates_uniqueness_of :clinic, scope: :doctor


  geocoded_by :_clinic_address, :latitude => 'spree_clinics.latitude', :longitude => 'spree_clinics.longitude'

  enum status: [:active, :deleted]

  # geocoded_by :_clinic_address

  # before_validation :check_if_blank

  # def check_if_blank
  #   unless clinic && consultation_price
  #     false
  #   end
  # end

  private
    
    def _clinic_address
      clinic.full_address
    end
end