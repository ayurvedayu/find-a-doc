require 'rails_helper'

RSpec.describe "spree/clinics/index", :type => :view do
  before(:each) do
    assign(:spree_clinics, [create(:clinic),
      create(:clinic, name: 'Second')
    ])
  end

  it "renders a list of spree/clinics" do
    render
    assert_select "tr>td", :text => "First".to_s
    assert_select "tr>td", :text => "Second".to_s
  end
end
