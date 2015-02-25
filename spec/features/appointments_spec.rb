require 'rails_helper'

feature "Appointments", :type => [:feature, :mailer] do

  let(:empl) { create(:doctor_employment) }
  # before { ActionMailer::Base.deliveries = [] }
  def prepare_appointment
    visit spree.doctor_search_results_path(dn: empl.doctor.name, search_for: 'doctor')

    click_link 'Book an appointment'

    choose '15:00'
    fill_in('Your name', :with => Faker::Name.name)
    fill_in('Mobile', :with => Faker::PhoneNumber.phone_number)
    fill_in('Address', :with => Faker::Address.street_address)
    fill_in('Cause', :with => Faker::Lorem.paragraph)
  end


  context 'guest user' do 
    context 'non-auto confirmable doctor' do
      it 'receives the ask to confirm and confirms' do
        empl.doctor.update auto_confirmable: false

        prepare_appointment
        fill_in('Email', :with => Faker::Internet.email)

        click_button('Book')

        fill_in 'Verification code from SMS', with: Spree::Appointment.last.verifications.last.token

        click_button 'Verify'

        expect(Spree::Appointment.last).to be_pending_doctor

        expect(ActionMailer::Base.deliveries.count).to eq(2)

        sign_in_as! empl.doctor.user

        # print page.html
        # byebug
        click_link 'Confirm'

        expect(Spree::Appointment.last).to be_initiated

        expect(ActionMailer::Base.deliveries.count).to eq(4)
      end
    end
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

        expect(page).to have_text(Spree::Appointment.last.scheduled_at_time)
          
        visit spree.account_path
        # byebug
        # print page.html
        click_link 'Mark as completed'


        check('Recommend that doctor')
        fill_in('appointment_review_attributes_text', :with => 'Review text')


        click_button "Save"

        expect(Spree::Appointment.last).to be_completed

        expect(Spree::Appointment.last.doctor_employment.doctor.recommendations).to be_present


      end
      it "can cancel appointment" do
        user = create(:confirmed_user)
        sign_in_as!(user)
        prepare_appointment
        click_button 'Book'
        visit spree.account_path

        click_link('Cancel')

        expect{click_button('Proceed')}.to change{ActionMailer::Base.deliveries.count}.by(1)

        expect(ActionMailer::Base.deliveries.last.to.first).to eq(empl.doctor.user.email)
        expect(Spree::Appointment.last).to be_canceled
      end
      it "receives the email" do
        user = create(:confirmed_user)

        sign_in_as!(user)

        prepare_appointment

        expect{click_button('Book')}.to change{ActionMailer::Base.deliveries.count}.by(2)
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
