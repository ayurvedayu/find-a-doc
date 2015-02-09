require 'rails_helper'

feature "DoctorSettings", :type => :feature do
  include Warden::Test::Helpers
  Warden.test_mode!

  before(:each) do
    empl = create(:doctor_employment)
    doctor = empl.doctor 
    login_as(doctor.user)
  end

  def create_clinic
    click_link 'or create one'

    fill_in 'Name', with: (vals[:name] = Faker::Company.name)
    select 'Bangalore', from: 'City'
    fill_in 'Suburb/Village', with: (vals[:sub] = 'anekal')
    fill_in 'Street', with: (vals[:str] = 'S N L Road')
    fill_in 'Description', with: (vals[:desc] = Faker::Lorem.paragraph)
    fill_in 'Services', with: 'braces, smile makeovers'
    select 'Ayurveda', from: 'Clinic type'

    click_button 'Create'
  end

  let (:vals) { Hash.new }

  scenario 'doctor sets simple attributes' do
    visit spree.edit_account_path

    fill_in 'Name', with: (vals[:name] = Faker::Name.name)
    fill_in 'Description', with: (vals[:desc] = Faker::Lorem.paragraph)
    fill_in 'Degree', with: (vals[:bds] = 'BDS')
    fill_in 'Phone', with: (vals[:phone] = Faker::PhoneNumber.phone_number)

    click_button 'Update'

    click_link 'View public profile'

    expect(page).to have_text vals[:desc].truncate(80)
    expect(page).to have_text vals[:bds]
    expect(page).to have_text vals[:name]


  end

  scenario 'doctor creates clinic successfully' do
    visit spree.edit_account_path
    # create(:city)
    # create(:clinic_type)

    create_clinic

    expect(Spree::Clinic.last.services.last.name).to eq('Smile Makeovers')

    expect(page).to have_select('doctor_clinic_id', with_options: [ vals[:name] ])
  end

  scenario 'doctor creates time slots' do
    visit spree.edit_account_path


    create_clinic 

    select vals[:name], from: 'doctor_clinic_id'
    fill_in 'doctor_cons_price', with: 150

    # page.execute_script("$('#day_panel_1 .slider-time-range').slider('values',1000,1250)")

      # fill_in 'timing_start_time_1', with: '10:00'
      # fill_in 'timing_end_time_1', with: '18:00'
    find("#timing_start_time_1").set("10:00")
    find("#timing_end_time_1").set("18:00")
    within '#day_panel_1' do
      choose 'Working'
    end

    click_button 'Update'
    expect(Spree::Doctor.first.doctor_employments.last.timings.working.count).to eq(1)
    expect(Spree::Doctor.first.doctor_employments.last.timings.not_working.count).to eq(6)

  end
    
end
