# require 'rails_helper'

# RSpec.describe "spree/doctors/edit", :type => :view do
#   before(:each) do
#     @spree_doctor = assign(:spree_doctor, Spree::Doctor.create!(
#       :clinic => nil,
#       :user => nil,
#       :name => "MyString",
#       :description => "MyText",
#       :phone => "MyText",
#       :is_for_instance_booking => false
#     ))
#   end

#   it "renders the edit spree_doctor form" do
#     render

#     assert_select "form[action=?][method=?]", spree_doctor_path(@spree_doctor), "post" do

#       assert_select "input#spree_doctor_clinic_id[name=?]", "spree_doctor[clinic_id]"

#       assert_select "input#spree_doctor_user_id[name=?]", "spree_doctor[user_id]"

#       assert_select "input#spree_doctor_name[name=?]", "spree_doctor[name]"

#       assert_select "textarea#spree_doctor_description[name=?]", "spree_doctor[description]"

#       assert_select "textarea#spree_doctor_phone[name=?]", "spree_doctor[phone]"

#       assert_select "input#spree_doctor_is_for_instance_booking[name=?]", "spree_doctor[is_for_instance_booking]"
#     end
#   end
# end
