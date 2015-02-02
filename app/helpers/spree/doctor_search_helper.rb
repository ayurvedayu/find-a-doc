module Spree::DoctorSearchHelper
  def active_nav_tab tab_name
    'active' if params[:search_for].eql?(tab_name) or (tab_name.eql?('specialty') and params[:search_for].blank?)
  end
end
