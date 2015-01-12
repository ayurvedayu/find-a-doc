Spree::UsersController.class_eval do

end

# adjust permitted params
Spree::PermittedAttributes.user_attributes << [:make_role, doctor_attributes: [:clinic_id, :name, :description, :phone, :is_for_instant_booking, :id]]
