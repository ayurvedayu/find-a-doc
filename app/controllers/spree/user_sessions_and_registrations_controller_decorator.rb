def after_sign_up_or_in_path resource
	if resource.doctor? || resource.clinic?
	  spree.edit_account_path
	else
	  super
	end
end

Spree::UserSessionsController.class_eval do
  def after_sign_in_path_for(resource)
		after_sign_up_or_in_path resource  
  end
end

Spree::UserRegistrationsController.class_eval do
  def after_sign_up_path_for(resource)
  	after_sign_up_or_in_path resource
  end
end