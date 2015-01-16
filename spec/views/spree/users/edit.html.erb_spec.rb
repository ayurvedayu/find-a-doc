require 'rails_helper'

RSpec.describe "spree/users/edit", :type => :view do
  let(:user) { create(:user) }

  before do
    assign :user, user
    allow(controller).to  receive(:current_spree_user).and_return user
  end

  it "doesn't renders user role select" do
    render
    assert_select "select#user_make_role[name='user[make_role]']", false
  end
end
