require 'rails_helper'

feature "Appointments", :type => :feature do

  let(:empl) { create(:doctor_employment) }
  def prepare_appointment

    visit spree.doctor_search_results_path(dn: empl.doctor.name)

    click_link 'Book an appointment'

    choose '15:00'
    fill_in('Your name', :with => Faker::Name.name)
    fill_in('Mobile', :with => Faker::PhoneNumber.phone_number)
    fill_in('Address', :with => Faker::Address.street_address)
    fill_in('Cause', :with => Faker::Lorem.paragraph)
  end

  context 'guest user' do 
    it 'receives phone verification whilst booking' do
      prepare_appointment
      fill_in('Email', :with => Faker::Internet.email)

      click_button('Book')

      expect(page).to have_button 'Verify'      

      expect(Spree::Verification.last).to eq(Spree::Appointment.last.verifications.last)
    end

    it 'books the appointment' do

      prepare_appointment
      fill_in('Email', :with => Faker::Internet.email)
      
      expect{click_button('Book')}.to change{Spree::Appointment.count}.by(1)


      fill_in 'Verification code from SMS', with: Spree::Appointment.last.verifications.last.token

      click_button 'Verify'
      
      expect(Spree::Appointment.last).to be_initiated
      expect(page).to have_text(Spree::Appointment.last.scheduled_at_time)
    end
  end

  context 'registered user' do
    context 'verified phone' do
      it "books and closes the appointment" do
        user = create(:confirmed_user)

        sign_in_as!(user)

        prepare_appointment

        expect{click_button('Book')}.to change{Spree::Appointment.count}.by(1)

        expect(Spree::Appointment.last).to be_initiated

        expect(page).to have_text(Spree::Appointment.last.scheduled_at_time
          
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
    context 'unverified phone' do 
      it 'receives phone verification' do
        user = create(:unverified_confirmed_user)

        sign_in_as!(user)

        prepare_appointment
        click_button('Book')

        expect(page).to have_button 'Verify'      

        expect(Spree::Verification.last.id).to eq(Spree::Appointment.last.verifications.last.id)
      end
    end
  end
end
