def after_sign_up_or_in_path_for resource
	if resource.doctor? || resource.clinic?
	  spree.edit_account_path
	else
    yield
	end
end

Spree::UserSessionsController.class_eval do
  def after_sign_in_path_for(resource)
		after_sign_up_or_in_path_for resource do
      super
    end
  end
end

Spree::UserRegistrationsController.class_eval do
  def after_sign_up_path_for(resource)
    after_sign_up_or_in_path_for resource do 
      super
    end
  end
end