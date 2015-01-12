require "rails_helper"

RSpec.describe Spree::ClinicsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/spree/clinics").to route_to("spree/clinics#index")
    end

    it "routes to #new" do
      expect(:get => "/spree/clinics/new").to route_to("spree/clinics#new")
    end

    it "routes to #show" do
      expect(:get => "/spree/clinics/1").to route_to("spree/clinics#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/spree/clinics/1/edit").to route_to("spree/clinics#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/spree/clinics").to route_to("spree/clinics#create")
    end

    it "routes to #update" do
      expect(:put => "/spree/clinics/1").to route_to("spree/clinics#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/spree/clinics/1").to route_to("spree/clinics#destroy", :id => "1")
    end

  end
end
