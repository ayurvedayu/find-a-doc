require 'rails_helper'

describe 'spree/shared/_main_nav_bar.html.erb' do
  it 'displays link to a doctor search' do

    render

    expect(rendered).to match Regexp.new link_to 'Find a Doctor', spree.doctor_search_path
  end
end