require 'rails_helper'

feature "PhoneVerifications", :type => :feature do  
  include Warden::Test::Helpers
  Warden.test_mode!

  scenario 'doctor verifies phone and available for search' do
    empl = create(:unverified_doctor_employment)
    doctor = empl.doctor
    doctor.user.doctor = doctor
    login_as(doctor.user)
    byebug
    visit spree.account_path

    click_button 'Send activation code'


    fill_in 'verification[token]', with: doctor.user.verifications.active.last.token
    click_button 'Verify'


    expect(page).to have_text 'Your phone is succesfully verified'

    visit spree.doctor_search_path

    fill_in('dn', with: doctor.name)
    within('#by_name') { click_button 'Go' }

    expect(page).to have_text "Dr. #{doctor.name}"
  end

  scenario 'doctor not verifies phone and not available' do
    empl = create(:unverified_doctor_employment)
    
    doctor = empl.doctor

    visit spree.doctor_search_path

    fill_in('dn', with: doctor.name)
    within('#by_name') { click_button 'Go' }

    expect(page).not_to have_text "Dr. #{doctor.name}"
  end
end
