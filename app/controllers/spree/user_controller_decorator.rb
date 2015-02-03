Spree::UsersController.class_eval do
  before_action :set_return_to, only: :edit
  before_action :build_employment, only: :edit

  # before_action :delete_empty_employment, only: :create


  # def delete_empty_employment 


  # end


  def build_employment
    current_spree_user.doctor.doctor_employments.build
  end

  def set_return_to
    session[:return_to] = edit_account_path
  end

end

# adjust permitted params
Spree::PermittedAttributes.user_attributes << [:make_role, 
                doctor_attributes: [:clinic_id,
                                    :name,
                                    :description, 
                                    :phone, 
                                    :is_for_instant_booking, 
                                    :id,
                                    :degree, 
                                    :specialty_ids => [] , 
                                    :doctor_employments_attributes =>  [:id,
                                                                        :clinic_id,
                                                                        :consultation_price,
                                                                        :consultation_currency]]]
