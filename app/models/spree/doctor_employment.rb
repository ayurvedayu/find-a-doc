class Spree::DoctorEmployment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :clinic

  validates_numericality_of :consultation_price

  validates_uniqueness_of :clinic, scope: :doctor

  geocoded_by :_clinic_address, :latitude => 'spree_clinics.latitude', :longitude => 'spree_clinics.longitude'
  # geocoded_by :_clinic_address

  private
    
    def _clinic_address
      clinic.full_address
    end
end
