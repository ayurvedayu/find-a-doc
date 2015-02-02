class Spree::AppointmentsController < Spree::HomeController
  before_action :set_spree_appointment, only: [:show, :edit, :update, :destroy, :complete, :cancel]

  # GET /spree/appointments
  def index
    @spree_appointments = current_spree_user.appointments.all
  end

  # GET /spree/appointments/1
  def show
  end

  # GET /spree/appointments/new
  def new
    @spree_appointment = Spree::Appointment.new
  end

  # GET /spree/appointments/1/edit
  def edit
  end

  # POST /spree/appointments
  def create
    @spree_appointment = Spree::Appointment.new(spree_appointment_params)
    
    @spree_appointment.user = current_spree_user if current_spree_user

    @spree_appointment.status = "initiated"

    if @spree_appointment.save
      redirect_to account_path, notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /spree/appointments/1
  def update
    # if review = params[:appointment][:review]
      # Spree::Review.create()

    if @spree_appointment.update(spree_appointment_params)
      # create recommendation for doctor if asked to
      if params[:user_recommends]
        Spree::Recommendation.create!(user: current_spree_user, doctor: @spree_appointment.doctor_employment.doctor)
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

    # Only allow a trusted parameter "white list" through.
    def spree_appointment_params
      params.require(:appointment).permit(:doctor_employment_id, :status, :name, :phone, :address, :email, :cause, :payment, :scheduled_at, :comment, :review_attributes => [:text,:user_id,:doctor_id])
    end
end
