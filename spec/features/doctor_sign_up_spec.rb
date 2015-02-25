require 'rails_helper'

RSpec.describe 'Sign up process' do 
  
  it 'signs up as a doctor' do
    visit spree.doctor_signup_path
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: 'secret'
    fill_in 'Password Confirmation', with: 'secret'
    click_button 'Create'

    user = Spree::User.last

    expect(user).to have_spree_role 'doctor'

    expect(user.doctor).to be_persisted
  end
end