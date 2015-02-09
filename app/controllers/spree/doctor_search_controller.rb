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

    @filter = params[:filter] || {}

    
    @doctor_employments = Spree::DoctorEmployment.joins(:timings, :clinic, 'LEFT JOIN "spree_doctors_specialties"  ON "spree_doctors_specialties"."doctor_id" = "spree_doctors"."id"  LEFT JOIN "spree_specialties" ON "spree_specialties"."id" = "spree_doctors_specialties"."specialty_id"', doctor: :user).where("spree_users.phone_is_verified = ?", true)
    
    case search_for
    when 'specialty'
      @doctor_employments = @doctor_employments.where(:spree_specialties => { :id => specialties } )
      @doctor_employments = @doctor_employments.near(location, within) if location.present?

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
                          .group('spree_doctor_employments.id, spree_clinics.latitude, spree_clinics.longitude')
                          .select("spree_doctor_employments.*, count(spree_appointments.id)")
                          # .group('spree_doctor_employments.*')

    @doctor_employments = @doctor_employments.where('spree_doctors.is_for_instant_booking = ?', @filter[:ib]) if @filter[:ib]
    @doctor_employments = @doctor_employments.where('spree_timings.day = ? and spree_timings.is_working_day = 1', @filter[:day]) if @filter[:day] and @filter[:day] != 'any'
    @doctor_employments = @doctor_employments.where(consultation_price: @filter[:price][:min]..@filter[:price][:max]) if @filter[:price]

    @doctor_employments = @doctor_employments.where(':min between spree_timings.start_time and spree_timings.end_time or :max between spree_timings.start_time and spree_timings.end_time or (spree_timings.start_time <= :min and spree_timings.end_time >= :max)', { min: @filter[:time][:max], max: @filter[:time][:min] }) if @filter[:time]

    [:price, :time].each do |f|
      @filter[f], @filter[f][:min], @filter[f][:max] = {}, nil, nil unless @filter[f]
    end
    




  end
end
