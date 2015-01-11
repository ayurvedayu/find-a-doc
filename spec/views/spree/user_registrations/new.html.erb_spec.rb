require 'rails_helper'

RSpec.describe "spree/user_registrations/new", :type => :view do
  before do
    allow(view).to receive(:resource).and_return(Spree::User.new)
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
  end

  it "renders user role select" do
    render
    assert_select "select#spree_user_make_role[name=?]", "spree_user[make_role]"
  end
end
