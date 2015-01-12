require 'rails_helper'

RSpec.describe "spree/clinics/index", :type => :view do
  before(:each) do
    assign(:spree_clinics, [
      Spree::Clinic.create!(
        :suburb => nil,
        :user => nil,
        :latitude => "Latitude",
        :longitude => "Longitude",
        :description => "MyText",
        :clinic_type => nil,
        :street => "Street",
        :building => "Building"
      ),
      Spree::Clinic.create!(
        :suburb => nil,
        :user => nil,
        :latitude => "Latitude",
        :longitude => "Longitude",
        :description => "MyText",
        :clinic_type => nil,
        :street => "Street",
        :building => "Building"
      )
    ])
  end

  it "renders a list of spree/clinics" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Latitude".to_s, :count => 2
    assert_select "tr>td", :text => "Longitude".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "Building".to_s, :count => 2
  end
end
