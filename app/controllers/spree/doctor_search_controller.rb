class Spree::DoctorSearchController < Spree::HomeController
  def index
  end

  def show
    specialties = params.delete(:ds)
    location = params.delete(:dl)
    nearby_clinics_ids = Spree::Clinic.near(location).map(&:id)
    # nearby_clinics = Spree::Clinic.all
    @doctors = Spree::Doctor.joins(:specialties, :clinic).where('spree_specialties.id in (?) and spree_doctors.clinic_id in (?)', specialties, nearby_clinics_ids)
  end
end
