require 'rails_helper'

RSpec.describe 'New signup process' do

  it 'assignes selected role to user' do
    get '/signup'
    expect(response).to render_template(:new)

    post "/signup", spree_user: { email: 'test@test.com',
                                  password: 'secret', 
                                  password_confirmation: 'secret', 
                                  make_role: 'doctor'}
    user = Spree::User.last

    expect(user).to have_spree_role 'doctor'
  end

  it 'redirects to the profile if not simple user' do
    post "/signup", spree_user: { email: 'test@test.com',
                                  password: 'secret', 
                                  password_confirmation: 'secret', 
                                  make_role: 'doctor'}
    
    expect(response).to redirect_to(spree.edit_account_path) 
    # expect(response)
  end
end

