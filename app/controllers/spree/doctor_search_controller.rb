class Spree::DoctorSearchController < Spree::HomeController
  def index
  end

  def show
    specialties = params.delete(:ds)
    location = params.delete(:dl)
    nearby_clinics = Spree::Clinic.near(location)
    # nearby_clinics = Spree::Clinic.all
    Spree::Doctor.joins(:specialties, :clinic).where('spree_specialties.name in (?) and spree_doctor.clinic_id in (?)', specialties, nearby_clinics)
  end
end
