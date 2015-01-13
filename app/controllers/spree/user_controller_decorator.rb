Spree::UsersController.class_eval do
  before_action :set_return_to, only: :edit

  def set_return_to
    session[:return_to] = edit_account_path
  end

end

# adjust permitted params
Spree::PermittedAttributes.user_attributes << [:make_role, doctor_attributes: [:clinic_id, :name, :description, :phone, :is_for_instant_booking, :id, { :specialty_ids => [] } ]]
