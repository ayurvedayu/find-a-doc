class Spree::DoctorSearchController < Spree::HomeController
  def index
  end


  # TODO list not geocoded clinics at the end of list
  def show
    specialties = params.delete(:ds)
    location = params.delete(:dl)
    within = '50'
    
    # nearby_clinics_ids = Spree::Clinic.near(location, within).map(&:id)
    # nearby_clinics = Spree::Clinic.near(location, within)

    # @doctors = Spree::Doctor.joins(:specialties, :doctor_employments).where('spree_specialties.id in (?) and spree_doctor_employments.clinic_id in (?)', specialties, nearby_clinics_ids)
    # @doctor_employments = Spree::DoctorEmployment.joins(doctor: :specialties).where('spree_specialties.id in (?) and spree_doctor_employments.clinic_id in (?)', specialties, nearby_clinics_ids)
    @doctor_employments = Spree::DoctorEmployment.joins(:clinic, doctor: :specialties).near(location, within)
  end
end
