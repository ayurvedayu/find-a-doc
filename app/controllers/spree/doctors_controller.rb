class Spree::DoctorsController < Spree::HomeController
  before_action :set_spree_doctor, only: [:show, :edit, :update, :destroy]

  # GET /spree/doctors
  def index
    @spree_doctors = Spree::Doctor.all
  end

  # GET /spree/doctors/1
  def show
  end

  # GET /spree/doctors/new
  def new
    @spree_doctor = Spree::Doctor.new
  end

  # GET /spree/doctors/1/edit
  def edit
  end

  # POST /spree/doctors
  def create
    @spree_doctor = Spree::Doctor.new(spree_doctor_params)

    if @spree_doctor.save
      redirect_to @spree_doctor, notice: 'Doctor was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /spree/doctors/1
  def update
    if @spree_doctor.update(spree_doctor_params)
      redirect_to @spree_doctor, notice: 'Doctor was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /spree/doctors/1
  def destroy
    @spree_doctor.destroy
    redirect_to spree_doctors_url, notice: 'Doctor was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spree_doctor
      @spree_doctor = Spree::Doctor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spree_doctor_params
      params.require(:spree_doctor).permit(:clinic_id, :user_id, :name, :description, :phone, :is_for_instance_booking, :specialty_ids)
    end
end
