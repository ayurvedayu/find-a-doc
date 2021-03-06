require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe Spree::ClinicsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Spree::Clinic. As you add validations to Spree::Clinic, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Spree::ClinicsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:user) { create(:confirmed_user) }

  before(:each) do
    # assign :user, user
    # sign_in user
    allow(controller).to  receive(:current_spree_user).and_return user
  end

  describe "GET index" do
    it "assigns all spree_clinics as @spree_clinics" do
      clinic = Spree::Clinic.create! valid_attributes
      spree_get :index, {}, valid_session
      expect(assigns(:spree_clinics)).to eq([clinic])
    end
  end

  describe "GET show" do
    it "assigns the requested spree_clinic as @spree_clinic" do
      clinic = Spree::Clinic.create! valid_attributes
      spree_get :show, {:id => clinic.to_param}, valid_session
      expect(assigns(:spree_clinic)).to eq(clinic)
    end
  end

  describe "GET new" do
    it "assigns a new spree_clinic as @spree_clinic" do
      sign_in user
      # byebug
      spree_get :new, {}, valid_session
      expect(assigns(:spree_clinic)).to be_a_new(Spree::Clinic)
    end
  end

  describe "GET edit" do
    it "assigns the requested spree_clinic as @spree_clinic" do
      clinic = Spree::Clinic.create! valid_attributes
      spree_get :edit, {:id => clinic.to_param}, valid_session
      expect(assigns(:spree_clinic)).to eq(clinic)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Spree::Clinic" do
        expect {
          spree_post :create, {:spree_clinic => valid_attributes}, valid_session
        }.to change(Spree::Clinic, :count).by(1)
      end

      it "assigns a newly created spree_clinic as @spree_clinic" do
        spree_post :create, {:spree_clinic => valid_attributes}, valid_session
        expect(assigns(:spree_clinic)).to be_a(Spree::Clinic)
        expect(assigns(:spree_clinic)).to be_persisted
      end

      it "redirects to the created spree_clinic" do
        spree_post :create, {:spree_clinic => valid_attributes}, valid_session
        expect(response).to redirect_to(Spree::Clinic.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved spree_clinic as @spree_clinic" do
        spree_post :create, {:spree_clinic => invalid_attributes}, valid_session
        expect(assigns(:spree_clinic)).to be_a_new(Spree::Clinic)
      end

      it "re-renders the 'new' template" do
        spree_post :create, {:spree_clinic => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested spree_clinic" do
        clinic = Spree::Clinic.create! valid_attributes
        spree_put :update, {:id => clinic.to_param, :spree_clinic => new_attributes}, valid_session
        clinic.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested spree_clinic as @spree_clinic" do
        clinic = Spree::Clinic.create! valid_attributes
        spree_put :update, {:id => clinic.to_param, :spree_clinic => valid_attributes}, valid_session
        expect(assigns(:spree_clinic)).to eq(clinic)
      end

      it "redirects to the spree_clinic" do
        clinic = Spree::Clinic.create! valid_attributes
        spree_put :update, {:id => clinic.to_param, :spree_clinic => valid_attributes}, valid_session
        expect(response).to redirect_to(clinic)
      end
    end

    describe "with invalid params" do
      it "assigns the spree_clinic as @spree_clinic" do
        clinic = Spree::Clinic.create! valid_attributes
        spree_put :update, {:id => clinic.to_param, :spree_clinic => invalid_attributes}, valid_session
        expect(assigns(:spree_clinic)).to eq(clinic)
      end

      it "re-renders the 'edit' template" do
        clinic = Spree::Clinic.create! valid_attributes
        spree_put :update, {:id => clinic.to_param, :spree_clinic => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested spree_clinic" do
      clinic = Spree::Clinic.create! valid_attributes
      expect {
        delete :destroy, {:id => clinic.to_param}, valid_session
      }.to change(Spree::Clinic, :count).by(-1)
    end

    it "redirects to the spree_clinics list" do
      clinic = Spree::Clinic.create! valid_attributes
      delete :destroy, {:id => clinic.to_param}, valid_session
      expect(response).to redirect_to(spree_clinics_url)
    end
  end

end
