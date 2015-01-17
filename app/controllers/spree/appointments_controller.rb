class Spree::AppointmentsController < Spree::HomeController
  before_action :set_spree_appointment, only: [:show, :edit, :update, :destroy]

  # GET /spree/appointments
  def index
    @spree_appointments = current_spree_user.appointments.all
  end

  # GET /spree/appointments/1
  def show
  end

  # GET /spree/appointments/new
  def new
    @spree_appointment = current_spree_user.appointments.new
  end

  # GET /spree/appointments/1/edit
  def edit
  end

  # POST /spree/appointments
  def create
    @spree_appointment = current_spree_user.appointments.new(spree_appointment_params)

    if @spree_appointment.save
      redirect_to @spree_appointment, notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /spree/appointments/1
  def update
    if @spree_appointment.update(spree_appointment_params)
      redirect_to @spree_appointment, notice: 'Appointment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /spree/appointments/1
  def destroy
    @spree_appointment.destroy
    redirect_to spree_appointments_url, notice: 'Appointment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spree_appointment
      @spree_appointment = current_spree_user.appointments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spree_appointment_params
      params.require(:spree_appointment).permit(:user_id, :doctor_employment_id, :status, :name, :phone, :address, :email, :cause, :payment)
    end
end
