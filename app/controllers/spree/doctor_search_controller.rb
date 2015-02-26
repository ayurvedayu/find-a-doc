class Spree::DoctorSearchController < Spree::HomeController
  def index
  end


  # TODO list not geocoded clinics at the end of list
  def show
    @result = Spree::DoctorSearchResult.new ds_params.merge(within: 50)
    @filter = @result.filter
  end

  def ds_params
    params.permit(:ds, :dl, :dn, :cn, :filter, :search_for, :utf8)
  end
end
