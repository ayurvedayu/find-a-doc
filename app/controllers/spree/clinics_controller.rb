class Spree::ClinicsController < Spree::UsersController
  before_action :set_spree_clinic, only: [:show, :edit, :update, :destroy]

  # GET /spree/clinics
  def index
    @spree_clinics = Spree::Clinic.all
  end

  # GET /spree/clinics/1
  def show
  end

  # GET /spree/clinics/new
  def new
    @spree_clinic = Spree::Clinic.new
    # @spree_clinic.suburb = Spree::Suburb.new
  end

  # GET /spree/clinics/1/edit
  def edit
  end

  # POST /spree/clinics
  def create
    @spree_clinic = Spree::Clinic.new(spree_clinic_params)

    if @spree_clinic.save
      redirect_to @spree_clinic, notice: 'Clinic was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /spree/clinics/1
  def update
    if @spree_clinic.update(spree_clinic_params)
      redirect_to @spree_clinic, notice: 'Clinic was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /spree/clinics/1
  def destroy
    @spree_clinic.destroy
    redirect_to spree_clinics_url, notice: 'Clinic was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spree_clinic
      @spree_clinic = Spree::Clinic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spree_clinic_params
      params.require(:spree_clinic).permit(:suburb_id, :user_id, :latitude, :longitude, :description, :clinic_type_id, :street, :building)
    end
end
