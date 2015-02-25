class Spree::AppointmentsController < Spree::HomeController
  before_action :set_spree_appointment, only: [:edit, :destroy, :complete]
  before_action :set_doctors_spree_appointment, only: :confirm

  # GET /spree/appointments
  def index
    @spree_appointments = current_spree_user.appointments.all
  end

  # GET /spree/appointments/1
  def show
    @spree_appointment = Spree::Appointment.find(params[:id])
  end

  # GET /spree/appointments/new
  def new
    @spree_appointment = Spree::Appointment.new
    @appointee = params[:for] == 'doctor' ? Spree::DoctorEmployment.find(params[:doctor_employment_id]) : Spree::Clinic.find(params[:clinic_id])
  end

  # GET /spree/appointments/1/edit
  def edit
  end

  # POST /spree/appointments
  def create
    @spree_appointment = Spree::Appointment.new(spree_appointment_params.merge(status: 'unverified'))
    @spree_appointment.user = current_spree_user if current_spree_user
    

    if @spree_appointment.save
      redirect_to edit_verification_path(@spree_appointment.active_verification) and return if need_to_verify_phone
      redirect_to @spree_appointment, notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /spree/appointments/1
  def update
    # if review = params[:appointment][:review]
      # Spree::Review.create()
    @spree_appointment = Spree::Appointment.find(params[:id])
    
    # @spree_appointment.check_token! params[:verification] if params[:verification]

    if @spree_appointment.update(spree_appointment_params)
      # create recommendation for doctor if asked to
      # if @spree_appointment.initiated?
        # flash.now[:notice] = 'Appointment successfully initiated.'
        # render 'show' and return # very bad too
      # end

      redirect_to account_path, notice: 'Appointment was successfully updated.'
    else
      redirect_to :back, alert: 'Appointment was not successfully updated.'
    end
  end


  def complete
    @spree_appointment.build_review
  end

  def cancel
    if current_spree_user.doctor? || current_spree_user.clinic?
      @apt = current_spree_user.doctor.appointments.find(params[:id])
      @he = 'doctor'
      # @email = @apt.email
      # @phone = @apt.phone
    else
      @apt = current_spree_user.appointments.find(params[:id])
      @he = 'user'
      # @email = @apt.doctor.user.email
      # @phone = @apt.doctor.phone
    end


  end

  def verify
    @spree_appointment = Spree::Appointment.find(params[:id])
    @verification = @spree_appointment.verifications.where( status: 'active', phone: @spree_appointment.phone).order(created_at: :desc).first_or_create
  end

  def confirm
    @spree_appointment.initiated!
    redirect_to account_path, notice: 'Appointment successfully confirmed.'
  end


  # DELETE /spree/appointments/1
  # def destroy
  #   @spree_appointment.destroy
  #   redirect_to spree_appointments_url, notice: 'Appointment was successfully destroyed.'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spree_appointment
      @spree_appointment = current_spree_user.appointments.find(params[:id])
    end
    def set_doctors_spree_appointment
      @spree_appointment = current_spree_user.doctor.appointments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spree_appointment_params
      params.require(:appointment).permit(:doctor_employment_id, :appointmentable_id, :appointmentable_type, :recommended,  :canceled_by, :status, :name, :phone, :address, :email, :cause, :payment, :scheduled_at, :comment, :review_attributes => [:text,:user_id,:doctor_id])
    end

    def need_to_verify_phone
      (current_spree_user.nil? and @spree_appointment.unverified?) or ( current_spree_user and ! current_spree_user.phone_is_verified?)
    end

    
end