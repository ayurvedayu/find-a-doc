class Spree::DoctorSearchController < Spree::HomeController
  def index
  end

  def show
    specialties = params.delete(:ds)
    location = params.delete(:dl)

    Spree::Doctor.includes(:doctor_specialties, :clinics).where(doctor_specialties: specialties).near(location)
  end
end
