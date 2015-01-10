Spree::UserSessionsController.class_eval do
  def after_sign_in_path_for(resource)
  	if resource.doctor? || resource.clinic?
		  spree.edit_user_path(spree_current_user)
		else
  	  super
  	end
  end
end