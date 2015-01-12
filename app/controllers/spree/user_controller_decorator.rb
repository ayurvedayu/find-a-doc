Spree::UsersController.class_eval do

end


Spree::PermittedAttributes.user_attributes << [:make_role, :doctor_attributes]
