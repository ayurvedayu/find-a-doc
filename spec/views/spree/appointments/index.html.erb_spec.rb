# require 'rails_helper'

# RSpec.describe "spree/appointments/index", :type => :view do
#   before(:each) do
#     assign(:spree_appointments, [
#       Spree::Appointment.create!(
#         :belongs_to => "",
#         :belongs_to => "",
#         :status => 1,
#         :name => "Name",
#         :phone => "Phone",
#         :address => "Address",
#         :email => "Email",
#         :cause => "MyText",
#         :payment => 2
#       ),
#       Spree::Appointment.create!(
#         :belongs_to => "",
#         :belongs_to => "",
#         :status => 1,
#         :name => "Name",
#         :phone => "Phone",
#         :address => "Address",
#         :email => "Email",
#         :cause => "MyText",
#         :payment => 2
#       )
#     ])
#   end

#   it "renders a list of spree/appointments" do
#     render
#     assert_select "tr>td", :text => "".to_s, :count => 2
#     assert_select "tr>td", :text => "".to_s, :count => 2
#     assert_select "tr>td", :text => 1.to_s, :count => 2
#     assert_select "tr>td", :text => "Name".to_s, :count => 2
#     assert_select "tr>td", :text => "Phone".to_s, :count => 2
#     assert_select "tr>td", :text => "Address".to_s, :count => 2
#     assert_select "tr>td", :text => "Email".to_s, :count => 2
#     assert_select "tr>td", :text => "MyText".to_s, :count => 2
#     assert_select "tr>td", :text => 2.to_s, :count => 2
#   end
# end
