Spree::UsersController.class_eval do
  before_action :set_return_to, only: :edit
  before_action :build_employment, only: :edit

  # before_action :delete_empty_employment, only: :create


  # def delete_empty_employment 


  # end

  def build_employment
    if current_spree_user.doctor?
      @new_employment = current_spree_user.doctor.doctor_employments.build
      
      @new_employment.timings = Spree::Timing.new_for_all_weekdays
    end
  end

  def set_return_to
    session[:return_to] = edit_account_path
  end

end

# adjust permitted params
timings_attrs = Spree::Timing::PERMITTED_ATTRS
dr_em_attrs = [:id, :clinic_id, :consultation_price, :consultation_currency, timings_attributes: timings_attrs]
doctor_attrs = [:clinic_id, :name, :description, :phone, :is_for_instant_booking, :id, :degree, :auto_confirmable, specialty_ids: [], doctor_employments_attributes: dr_em_attrs]
user_attributes = [:make_role, doctor_attributes: doctor_attrs ]
Spree::PermittedAttributes.user_attributes << user_attributes
