class Spree::DoctorSearchController < Spree::HomeController
  def index
  end

  def show
    specialties = params.delete(:ds)
    location = params.delete(:dl)
    nearby_clinics = Spree::Clinic.near(location)
    Spree::Doctor.includes(:doctor_specialties, :clinics).where(doctor_specialties: specialties, nearby_clinics: nearby_clinics.ids)
  end
end
