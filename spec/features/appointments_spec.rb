require 'rails_helper'

feature "Appointments", :type => :feature do
  scenario "User books the appointment" do
    user = create(:user)
    # clinic = create(:clinic)
    empl = create(:doctor_employment)
    # doctor = create(:instant_doctor)

    sign_in_as!(user)
    visit spree.doctor_search_results_path(dn: empl.doctor.name)
    print page.html
    byebug
    click_link 'Book an appointment'
    fill_in('Name', :with => 'Test')
    fill_in('Phone', :with => '+7 555 555 55 55')
    fill_in('Address', :with => 'address')
    fill_in('email', :with => user.email)
    fill_in('Cause', :with => 'some cause')

    expect(page).to render :something
  end
end
