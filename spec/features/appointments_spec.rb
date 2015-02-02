require 'rails_helper'

feature "Appointments", :type => :feature do
  context 'guest user' do 
    scenario 'booking the appointment' do
      empl = create(:doctor_employment)

      visit spree.doctor_search_results_path(dn: empl.doctor.name)

      click_link 'Book an appointment'
      fill_in('Your name', :with => 'Test')
      fill_in('Phone', :with => '+7 555 555 55 55')
      fill_in('Address', :with => 'address')
      fill_in('Email', :with => Faker::Internet.email)
      fill_in('Cause', :with => 'some cause')

      expect{click_button('Book')}.to change{Spree::Appointment.count}.by(1)

      expect(Spree::Appointment.last).to be_initiated
    end
  end

  context 'registered user' do
    scenario "User books and closes the appointment" do
      user = create(:confirmed_user)
      # clinic = create(:clinic)
      empl = create(:doctor_employment)
      # doctor = create(:instant_doctor)

      sign_in_as!(user)
      visit spree.doctor_search_results_path(dn: empl.doctor.name)
      # print page.html
      # byebug
      click_link 'Book an appointment'
      fill_in('Your name', :with => 'Test')
      fill_in('Phone', :with => '+7 555 555 55 55')
      fill_in('Address', :with => 'address')
      fill_in('Email', :with => user.email)
      fill_in('Cause', :with => 'some cause')

      expect{click_button('Book')}.to change{Spree::Appointment.count}.by(1)

      expect(Spree::Appointment.last).to be_initiated

      visit spree.account_path
      # byebug
      # print page.html
      click_link 'Mark as completed'


      check('user_recommends')
      fill_in('appointment_review_attributes_text', :with => 'Review text')


      click_button "Save"

      expect(Spree::Appointment.last).to be_completed

      expect(Spree::Appointment.last.doctor_employment.doctor.recommendations).to be_present

    end
  end
end
