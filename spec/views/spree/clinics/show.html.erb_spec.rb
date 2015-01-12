require 'rails_helper'

RSpec.describe "spree/clinics/show", :type => :view do
  before(:each) do
    @spree_clinic = assign(:spree_clinic, Spree::Clinic.create!(
      :suburb => nil,
      :user => nil,
      :latitude => "Latitude",
      :longitude => "Longitude",
      :description => "MyText",
      :clinic_type => nil,
      :street => "Street",
      :building => "Building"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Latitude/)
    expect(rendered).to match(/Longitude/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Street/)
    expect(rendered).to match(/Building/)
  end
end
