require 'spec_helper'

describe 'spree/shared/_main_nav_bar.html.erb' do
  it 'displays link to a doctor search' do
    # assign(:taxonomies, stub_model(Spree::Taxonomy))
    # assign(:taxonomies, [])
    render

    expect(rendered).to match /Find a Doctor/
  end
end