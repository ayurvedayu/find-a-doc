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
    fill_in 'Suburb/Village', with: (vals[:sub] = 'anekal')
    fill_in 'Street', with: (vals[:str] = 'S N L Road')
    fill_in 'Description', with: (vals[:desc] = Faker::Lorem.paragraph)
    fill_in 'Services', with: 'braces, smile makeovers'
    select 'Ayurveda', from: 'Clinic type'
    click_button 'Create'
    visit spree.doctor_search_path
    fill_in('cn', with: vals[:name])
    within('#by_clinic') { click_button 'Go' }

    expect(page).to have_text vals[:name]
  end
end
