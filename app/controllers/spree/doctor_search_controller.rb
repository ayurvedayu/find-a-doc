class Spree::DoctorSearchController < Spree::HomeController
  def index
  end


  # TODO list not geocoded clinics at the end of list
  def show
    specialties = params[:ds]
    location = params[:dl]
    within = '50' # km
    doctor_name = params[:dn]
    clinic_name = params[:cn]
    
    # nearby_clinics_ids = Spree::Clinic.near(location, within).map(&:id)
    # nearby_clinics = Spree::Clinic.near(location, within)

    # @doctors = Spree::Doctor.joins(:specialties, :doctor_employments).where('spree_specialties.id in (?) and spree_doctor_employments.clinic_id in (?)', specialties, nearby_clinics_ids)
# @doctor_employments = Spree::DoctorEmployment.joins(doctor: :specialties).where('spree_specialties.id in (?) and spree_doctor_employments.clinic_id in (?)', specialties, nearby_clinics_ids)
    @doctor_employments = Spree::DoctorEmployment.joins(:clinic, doctor: :specialties)
    
    case 
    when specialties && location
      @doctor_employments = @doctor_employments
                                    .near(location, within)
                                    .where(:spree_specialties => 
                                                      { :id => specialties } )
    when doctor_name
      @doctor_employments = @doctor_employments
                                      .where('spree_doctors.name like ?', 
                                                "%#{doctor_name}%")
    when clinic_name
      @doctor_employments = @doctor_employments
                                      .where('spree_clinics.name like ?', 
                                                "%#{clinic_name}%")                                                  
    end


  end
end
