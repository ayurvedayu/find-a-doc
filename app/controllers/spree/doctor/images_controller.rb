class Spree::Doctor::ImagesController < Spree::ImagesController
  def index
    @images = current_spree_user.doctor.images
    @action = doctor_images_path
  end

  def create
    @image = current_spree_user.doctor.images.new image_params

    current_spree_user.doctor.save!

    redirect_to doctor_images_path
  end
end