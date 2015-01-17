require 'rails_helper'

feature "Appointments", :type => :feature do
  scenario "User orders the appoitment" do
    user = create(:user)

    sign_in_as!(:user)

  end
end
