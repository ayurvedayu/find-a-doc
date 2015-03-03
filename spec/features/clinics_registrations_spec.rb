require 'rails_helper'

feature "ClinicsRegistrations", :type => :feature do
  it 'signs up as a clinic and creates clinic which is accessible throug search' do
    city, tp = create(:city), create(:clinic_type)
    visit spree.clinic_signup_path
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: 'secret'
    fill_in 'Password Confirmation', with: 'secret'
    click_button 'Create'

    user = Spree::User.last
    user.update confirmed_at: Time.now
    expect(user).to have_spree_role 'clinic'

    sign_in_as! user
    visit spree.new_account_clinic_path
    vals = {}
    fill_in 'Name', with: (vals[:name] = Faker::Company.name)
    select 'Bangalore', from: 'City'
    check 'Available for instant booking'
    fill_in 'Locality', with: (vals[:sub] = 'anekal')
    fill_in 'Phone', with: Faker::PhoneNumber.phone_number
    fill_in 'Street', with: (vals[:str] = 'S N L Road')
    fill_in 'Description', with: (vals[:desc] = Faker::Lorem.paragraph)
    fill_in 'Services', with: 'braces, smile makeovers'
    select 'Ayurveda', from: 'Clinic type'
    click_button 'Create'
    visit spree.doctor_search_path
    fill_in('cn', with: vals[:name])
    within('#by_clinic') { click_button 'Go' }

    expect(page).to have_text vals[:name]

    Spree::Clinic.last.timings.update_all is_working_day: '1'

    click_link 'Book an appointment'
    # byebug
    choose '15:00'
    fill_in('Your name', :with => Faker::Name.name)
    fill_in('Mobile', :with => Faker::PhoneNumber.phone_number)
    fill_in('Address', :with => Faker::Address.street_address)
    fill_in('Cause', :with => Faker::Lorem.paragraph)

    expect{click_button('Book')}.to change{Spree::Appointment.count}.by(1)

    fill_in 'Verification code from SMS', with: Spree::Appointment.last.verifications.last.token

    click_button 'Verify'


    expect(page).to have_text(Spree::Appointment.last.scheduled_at_time)
      
    visit spree.account_path
    # byebug
    print page.html
    click_link 'Mark as completed'


    check('Recommend that doctor')
    fill_in('appointment_review_attributes_text', :with => 'Review text')


    click_button "Save"

    expect(Spree::Appointment.last).to be_completed

    # expect(Spree::Appointment.last.doctor_employment.doctor.recommendations).to be_present

  end
end
