Spree::UsersController.class_eval do

  def profile
    @user = spree_current_user
    render :show
  end
end


Spree::PermittedAttributes.user_attributes << :make_role
