require 'rails_helper'

RSpec.describe "spree/doctors/index", :type => :view do
  before(:each) do
    assign(:spree_doctors, [
      Spree::Doctor.create!(
        :clinic => nil,
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :phone => "MyText",
        :is_for_instance_booking => false
      ),
      Spree::Doctor.create!(
        :clinic => nil,
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :phone => "MyText",
        :is_for_instance_booking => false
      )
    ])
  end

  it "renders a list of spree/doctors" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
