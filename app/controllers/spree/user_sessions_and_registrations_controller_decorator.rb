# def after_sign_up_or_in_path_for resource
# 	if resource.doctor? || resource.clinic?
# 	  spree.edit_account_path
# 	else
#     yield
# 	end
# end

Spree::UserSessionsController.class_eval do
  def after_sign_in_path_for(resource)
    if resource.doctor? || resource.clinic?
      spree.account_path
    else
      super
    end
  end
end

Spree::UserRegistrationsController.class_eval do

  def create
    @user = build_resource(spree_user_params)
    if resource.save
      if resource.active_for_authentication?
        set_flash_message(:notice, :signed_up)
        sign_in(:spree_user, @user)
        session[:spree_user_signup] = true
        associate_user
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      render :new
    end
  end


  def after_sign_up_path_for(resource)
    if resource.doctor? || resource.clinic?
      spree.edit_account_path
    else
      super
    end
  end

  def doctor_signup
    build_resource({})
    respond_with self.resource
    @user = resource
  end

  def clinic_signup
    build_resource({})
    respond_with self.resource
    @user = resource
  end
end