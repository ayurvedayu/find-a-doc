class Spree::Clinic::ImagesController < Spree::ImagesController
  before_action :set_clinic
  def index
    @images = @clinic.images
    @action = clinic_images_path
  end

  def create
    @image = @clinic.images.new image_params

    @clinic.save!

    redirect_to clinic_images_path
  end

  def set_clinic
    @clinic = Spree::Clinic.friendly.find(params[:id])
  end
end