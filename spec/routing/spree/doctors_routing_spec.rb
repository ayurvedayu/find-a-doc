require "rails_helper"

RSpec.describe Spree::DoctorsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/spree/doctors").to route_to("spree/doctors#index")
    end

    it "routes to #new" do
      expect(:get => "/spree/doctors/new").to route_to("spree/doctors#new")
    end

    it "routes to #show" do
      expect(:get => "/spree/doctors/1").to route_to("spree/doctors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/spree/doctors/1/edit").to route_to("spree/doctors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/spree/doctors").to route_to("spree/doctors#create")
    end

    it "routes to #update" do
      expect(:put => "/spree/doctors/1").to route_to("spree/doctors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/spree/doctors/1").to route_to("spree/doctors#destroy", :id => "1")
    end

  end
end
