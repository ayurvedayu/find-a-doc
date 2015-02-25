class Spree::DoctorSearchResult
  attr_reader :filter, :result

  def initialize params
    @specialties = params[:ds]
    @location = params[:dl]
    @within = params[:within]
    @doctor_name = params[:dn]
    @clinic_name = params[:cn]
    @search_for = params[:search_for]
    @filter = params[:filter] || {}
    

    search

    [:price, :time].each do |f|
      @filter[f], @filter[f][:min], @filter[f][:max] = {}, nil, nil unless @filter[f]
    end
  end

  def search
    if ['clinic', 'doctor', 'specialty'].include? @search_for
      send(@search_for)
    else
      throw ActiveRecord::RecordNotFound, 'provide [search_for] param'
    end
  end 

  def clinic
    @result = Spree::Clinic.joins(:user)
    @result = @result.where('lower(spree_clinics.name) LIKE lower(?)', "%#{@clinic_name}%") if @clinic_name
    # @result = de_joins.where('lower(spree_clinics.name) LIKE lower(?)', "%#{@clinic_name}%")
    clinic_filters
    # common
    # byebug
  end

  def doctor
    @result = de_joins.where('lower(spree_doctors.name) LIKE lower(?)', "%#{@doctor_name}%")
    de_appointments
    filters
    common
  end

  def specialty
    @result = de_joins
    @result = @result.where(:spree_specialties => { :id => @specialties } ) unless @specialties.blank?
    @result = @result.near(@location, @within) if @location.present?
    de_appointments
    filters
    common
    # byebug
  end

  def de_joins
    Spree::DoctorEmployment.joins(:timings, :clinic, 'LEFT JOIN "spree_doctors_specialties"  ON "spree_doctors_specialties"."doctor_id" = "spree_doctors"."id"  LEFT JOIN "spree_specialties" ON "spree_specialties"."id" = "spree_doctors_specialties"."specialty_id"', doctor: :user)
  end

  def de_appointments
    @result = @result.joins("LEFT JOIN spree_appointments ON spree_appointments.appointmentable_id = spree_doctor_employments.id and spree_appointments.appointmentable_type = 'Spree::DoctorEmployment' and spree_appointments.created_at between '#{30.days.ago.to_formatted_s(:db)}' and '#{DateTime.now.to_formatted_s(:db)}'")
    .order("count(spree_appointments.id) DESC")
    .group('spree_doctor_employments.id, spree_clinics.latitude, spree_clinics.longitude')
    .select("spree_doctor_employments.*, count(spree_appointments.id)")
  end

  def filters
    @result = @result.where('spree_doctors.is_for_instant_booking = ?', @filter[:ib]) if @filter[:ib]
    @result = @result.where('spree_timings.day = ? and spree_timings.is_working_day = 1', @filter[:day]) if @filter[:day] and @filter[:day] != 'any'
    @result = @result.where(consultation_price: @filter[:price][:min]..@filter[:price][:max]) if @filter[:price]

    @result = @result.where(':min between spree_timings.start_time and spree_timings.end_time or :max between spree_timings.start_time and spree_timings.end_time or (spree_timings.start_time <= :min and spree_timings.end_time >= :max)', { min: @filter[:time][:max], max: @filter[:time][:min] }) if @filter[:time]
  end

  def clinic_filters
    # @result = @result.where('spree_doctors.is_for_instant_booking = ?', @filter[:ib]) if @filter[:ib]
    @result = @result.where('spree_timings.day = ? and spree_timings.is_working_day = 1', @filter[:day]) if @filter[:day] and @filter[:day] != 'any'
    # @result = @result.where(consultation_price: @filter[:price][:min]..@filter[:price][:max]) if @filter[:price]

    @result = @result.where(':min between spree_timings.start_time and spree_timings.end_time or :max between spree_timings.start_time and spree_timings.end_time or (spree_timings.start_time <= :min and spree_timings.end_time >= :max)', { min: @filter[:time][:max], max: @filter[:time][:min] }) if @filter[:time]
  end
  def common
    @result = @result.where("spree_users.phone_is_verified = ?", true)
  end
end