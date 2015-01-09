require 'rails_helper'

describe Spree::DoctorSearchController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      spree_get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      spree_get :show
      expect(response).to have_http_status(:success)
    end
  end

end
