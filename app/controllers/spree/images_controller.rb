class Spree::ImagesController < Spree::HomeController
  def index
  end

  private
  
  def image_params
    params.require(:image).permit(:attachment)
  end
end