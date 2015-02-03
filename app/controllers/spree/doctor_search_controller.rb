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
    search_for = params[:search_for]
    
    @doctor_employments = Spree::DoctorEmployment.joins(:clinic, 'LEFT JOIN "spree_doctors_specialties"  ON "spree_doctors_specialties"."doctor_id" = "spree_doctors"."id"  LEFT JOIN "spree_specialties" ON "spree_specialties"."id" = "spree_doctors_specialties"."specialty_id"', doctor: :user).where("spree_users.phone_is_verified = ?", true)
    
    case search_for
    when 'specialty'
      @doctor_employments = @doctor_employments
                                    .near(location, within)
                                    .where(:spree_specialties => { :id => specialties } )
    when 'doctor'
      @doctor_employments = @doctor_employments
                                      .where('lower(spree_doctors.name) LIKE lower(?)', 
                                                "%#{doctor_name}%")
    when 'clinic'
      @doctor_employments = @doctor_employments.where('lower(spree_clinics.name) LIKE lower(?)',                                                "%#{clinic_name}%")                                                  
    end

    @doctor_employments = @doctor_employments
                          .joins("LEFT JOIN spree_appointments ON spree_appointments.doctor_employment_id = spree_doctor_employments.id and spree_appointments.created_at between '#{30.days.ago.to_formatted_s(:db)}' and '#{DateTime.now.to_formatted_s(:db)}'")
                          .order("count(spree_appointments.id) DESC")
                          .group('spree_doctor_employments.id')
                          .select("spree_doctor_employments.*, count(spree_appointments.id)")
                          # .group('spree_doctor_employments.*')



  end
end
