# require 'rails_helper'

# RSpec.describe "spree/clinics/edit", :type => :view do
#   before(:each) do
#     @spree_clinic = assign(:spree_clinic, create(:clinic) )
#   end

#   it "renders the edit spree_clinic form" do
#     render

#     assert_select "form[action=?][method=?]", spree_clinic_path(@spree_clinic), "post" do

#       assert_select "input#spree_clinic_suburb_id[name=?]", "spree_clinic[suburb_id]"

#       assert_select "input#spree_clinic_user_id[name=?]", "spree_clinic[user_id]"

#       assert_select "input#spree_clinic_latitude[name=?]", "spree_clinic[latitude]"

#       assert_select "input#spree_clinic_longitude[name=?]", "spree_clinic[longitude]"

#       assert_select "textarea#spree_clinic_description[name=?]", "spree_clinic[description]"

#       assert_select "input#spree_clinic_clinic_type_id[name=?]", "spree_clinic[clinic_type_id]"

#       assert_select "input#spree_clinic_street[name=?]", "spree_clinic[street]"

#       assert_select "input#spree_clinic_building[name=?]", "spree_clinic[building]"
#     end
#   end
# end
