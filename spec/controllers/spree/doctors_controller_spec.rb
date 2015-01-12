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

RSpec.describe Spree::DoctorsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Spree::Doctor. As you add validations to Spree::Doctor, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Spree::DoctorsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all spree_doctors as @spree_doctors" do
      doctor = Spree::Doctor.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:spree_doctors)).to eq([doctor])
    end
  end

  describe "GET show" do
    it "assigns the requested spree_doctor as @spree_doctor" do
      doctor = Spree::Doctor.create! valid_attributes
      get :show, {:id => doctor.to_param}, valid_session
      expect(assigns(:spree_doctor)).to eq(doctor)
    end
  end

  describe "GET new" do
    it "assigns a new spree_doctor as @spree_doctor" do
      spree_get :new, {}, valid_session
      expect(assigns(:spree_doctor)).to be_a_new(Spree::Doctor)
    end
  end

  describe "GET edit" do
    it "assigns the requested spree_doctor as @spree_doctor" do
      doctor = Spree::Doctor.create! valid_attributes
      get :edit, {:id => doctor.to_param}, valid_session
      expect(assigns(:spree_doctor)).to eq(doctor)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Spree::Doctor" do
        expect {
          post :create, {:spree_doctor => valid_attributes}, valid_session
        }.to change(Spree::Doctor, :count).by(1)
      end

      it "assigns a newly created spree_doctor as @spree_doctor" do
        post :create, {:spree_doctor => valid_attributes}, valid_session
        expect(assigns(:spree_doctor)).to be_a(Spree::Doctor)
        expect(assigns(:spree_doctor)).to be_persisted
      end

      it "redirects to the created spree_doctor" do
        post :create, {:spree_doctor => valid_attributes}, valid_session
        expect(response).to redirect_to(Spree::Doctor.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved spree_doctor as @spree_doctor" do
        post :create, {:spree_doctor => invalid_attributes}, valid_session
        expect(assigns(:spree_doctor)).to be_a_new(Spree::Doctor)
      end

      it "re-renders the 'new' template" do
        post :create, {:spree_doctor => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested spree_doctor" do
        doctor = Spree::Doctor.create! valid_attributes
        put :update, {:id => doctor.to_param, :spree_doctor => new_attributes}, valid_session
        doctor.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested spree_doctor as @spree_doctor" do
        doctor = Spree::Doctor.create! valid_attributes
        put :update, {:id => doctor.to_param, :spree_doctor => valid_attributes}, valid_session
        expect(assigns(:spree_doctor)).to eq(doctor)
      end

      it "redirects to the spree_doctor" do
        doctor = Spree::Doctor.create! valid_attributes
        put :update, {:id => doctor.to_param, :spree_doctor => valid_attributes}, valid_session
        expect(response).to redirect_to(doctor)
      end
    end

    describe "with invalid params" do
      it "assigns the spree_doctor as @spree_doctor" do
        doctor = Spree::Doctor.create! valid_attributes
        put :update, {:id => doctor.to_param, :spree_doctor => invalid_attributes}, valid_session
        expect(assigns(:spree_doctor)).to eq(doctor)
      end

      it "re-renders the 'edit' template" do
        doctor = Spree::Doctor.create! valid_attributes
        put :update, {:id => doctor.to_param, :spree_doctor => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested spree_doctor" do
      doctor = Spree::Doctor.create! valid_attributes
      expect {
        delete :destroy, {:id => doctor.to_param}, valid_session
      }.to change(Spree::Doctor, :count).by(-1)
    end

    it "redirects to the spree_doctors list" do
      doctor = Spree::Doctor.create! valid_attributes
      delete :destroy, {:id => doctor.to_param}, valid_session
      expect(response).to redirect_to(spree_doctors_url)
    end
  end

end