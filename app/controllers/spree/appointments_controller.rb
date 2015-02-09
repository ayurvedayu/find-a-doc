class Spree::AppointmentsController < Spree::HomeController
  before_action :set_spree_appointment, only: [:edit, :destroy, :complete]
  before_action :set_doctors_spree_appointment, only: [ :cancel, :confirm]

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
    @doctor_employment = Spree::DoctorEmployment.find(params[:doctor_employment_id])
  end

  # GET /spree/appointments/1/edit
  def edit
  end

  # POST /spree/appointments
  def create
    @spree_appointment = Spree::Appointment.new(spree_appointment_params.merge(status: 'unverified'))
    @doctor_employment = @spree_appointment.doctor_employment
    
    @spree_appointment.user = current_spree_user if current_spree_user

    # byebug
    if @spree_appointment.save

      redirect_to action: :verify, id: @spree_appointment.id and return if verify_phone

      if @spree_appointment.doctor_employment.doctor.auto_confirmable?
        @spree_appointment.initiated!
      else
        @spree_appointment.pending_doctor!
      end

      redirect_to account_path, notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /spree/appointments/1
  def update
    # if review = params[:appointment][:review]
      # Spree::Review.create()
    @spree_appointment = Spree::Appointment.find(params[:id])
    
    check_token! if params[:verification]

    # this needs to be better. a lot.
    if @spree_appointment.doctor_employment.doctor.auto_confirmable?
      @spree_appointment.initiated!
    else
      @spree_appointment.pending_doctor!
    end

    if @spree_appointment.update(spree_appointment_params)
      # create recommendation for doctor if asked to
      if params[:user_recommends]
        Spree::Recommendation.create!(user: current_spree_user, doctor: @spree_appointment.doctor_employment.doctor)
      end
      if @spree_appointment.initiated?
        flash.now[:notice] = 'Appointment successfully initiated.'
        render 'show' and return # very bad too
      end

      redirect_to account_path, notice: 'Appointment was successfully updated.'
    else
      redirect_to :back, alert: 'Appointment was not successfully updated.'
    end
  end


  def complete
    @spree_appointment.build_review
  end

  def cancel
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
      params.require(:appointment).permit(:doctor_employment_id, :status, :name, :phone, :address, :email, :cause, :payment, :scheduled_at, :comment, :review_attributes => [:text,:user_id,:doctor_id])
    end

    def verify_phone
      (current_spree_user.nil? and @spree_appointment.unverified?) or ( current_spree_user and ! current_spree_user.phone_is_verified?)
    end

    def check_token!
      if params[:verification][:token] and params[:verification][:id]
        vrf = Spree::Verification.find(params[:verification][:id])

        redirect_to action: :verify, id: @spree_appoinment.id, alert: 'Wrong token' and return  unless params[:verification][:token].eql? vrf.token
      end
    end
end