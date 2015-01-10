require 'rails_helper'

RSpec.describe "spree/doctors/show", :type => :view do
  before(:each) do
    @spree_doctor = assign(:spree_doctor, Spree::Doctor.create!(
      :clinic => nil,
      :user => nil,
      :name => "Name",
      :description => "MyText",
      :phone => "MyText",
      :is_for_instance_booking => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
  end
end
