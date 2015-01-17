# require 'rails_helper'

# RSpec.describe "spree/appointments/edit", :type => :view do
#   before(:each) do
#     @spree_appointment = assign(:spree_appointment, Spree::Appointment.create!(
#       :belongs_to => "",
#       :belongs_to => "",
#       :status => 1,
#       :name => "MyString",
#       :phone => "MyString",
#       :address => "MyString",
#       :email => "MyString",
#       :cause => "MyText",
#       :payment => 1
#     ))
#   end

#   it "renders the edit spree_appointment form" do
#     render

#     assert_select "form[action=?][method=?]", spree_appointment_path(@spree_appointment), "post" do

#       assert_select "input#spree_appointment_belongs_to[name=?]", "spree_appointment[belongs_to]"

#       assert_select "input#spree_appointment_belongs_to[name=?]", "spree_appointment[belongs_to]"

#       assert_select "input#spree_appointment_status[name=?]", "spree_appointment[status]"

#       assert_select "input#spree_appointment_name[name=?]", "spree_appointment[name]"

#       assert_select "input#spree_appointment_phone[name=?]", "spree_appointment[phone]"

#       assert_select "input#spree_appointment_address[name=?]", "spree_appointment[address]"

#       assert_select "input#spree_appointment_email[name=?]", "spree_appointment[email]"

#       assert_select "textarea#spree_appointment_cause[name=?]", "spree_appointment[cause]"

#       assert_select "input#spree_appointment_payment[name=?]", "spree_appointment[payment]"
#     end
#   end
# end
