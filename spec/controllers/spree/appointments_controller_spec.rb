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
# is no simpler way to spree_get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe Spree::AppointmentsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Spree::Appointment. As you add validations to Spree::Appointment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Spree::AppointmentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:user) { create(:user) }

  before do
    # assign :user, user
    allow(controller).to  receive(:current_spree_user).and_return user
  end

  describe "spree_get index" do
    it "assigns all spree_appointments as @spree_appointments" do
      appointment = Spree::Appointment.create! valid_attributes
      spree_get :index, {}, valid_session
      expect(assigns(:spree_appointments)).to eq([appointment])
    end
  end

  describe "spree_get show" do
    it "assigns the requested spree_appointment as @spree_appointment" do
      appointment = Spree::Appointment.create! valid_attributes
      spree_get :show, {:id => appointment.to_param}, valid_session
      expect(assigns(:spree_appointment)).to eq(appointment)
    end
  end

  describe "spree_get new" do
    it "assigns a new spree_appointment as @spree_appointment" do
      empl = create(:doctor_employment)
      spree_get :new, {:doctor_employment_id => empl.id}, valid_session
      expect(assigns(:spree_appointment)).to be_a_new(Spree::Appointment)
    end
  end

  describe "spree_get edit" do
    it "assigns the requested spree_appointment as @spree_appointment" do
      appointment = Spree::Appointment.create! valid_attributes
      spree_get :edit, {:id => appointment.to_param}, valid_session
      expect(assigns(:spree_appointment)).to eq(appointment)
    end
  end

  describe "spree_post create" do
    describe "with valid params" do
      it "creates a new Spree::Appointment" do
        expect {
          spree_post :create, {:spree_appointment => valid_attributes}, valid_session
        }.to change(Spree::Appointment, :count).by(1)
      end

      it "assigns a newly created spree_appointment as @spree_appointment" do
        spree_post :create, {:spree_appointment => valid_attributes}, valid_session
        expect(assigns(:spree_appointment)).to be_a(Spree::Appointment)
        expect(assigns(:spree_appointment)).to be_persisted
      end

      it "redirects to the created spree_appointment" do
        spree_post :create, {:spree_appointment => valid_attributes}, valid_session
        expect(response).to redirect_to(Spree::Appointment.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved spree_appointment as @spree_appointment" do
        spree_post :create, {:spree_appointment => invalid_attributes}, valid_session
        expect(assigns(:spree_appointment)).to be_a_new(Spree::Appointment)
      end

      it "re-renders the 'new' template" do
        spree_post :create, {:spree_appointment => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested spree_appointment" do
  #       appointment = Spree::Appointment.create! valid_attributes
  #       put :update, {:id => appointment.to_param, :spree_appointment => new_attributes}, valid_session
  #       appointment.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "assigns the requested spree_appointment as @spree_appointment" do
  #       appointment = Spree::Appointment.create! valid_attributes
  #       put :update, {:id => appointment.to_param, :spree_appointment => valid_attributes}, valid_session
  #       expect(assigns(:spree_appointment)).to eq(appointment)
  #     end

  #     it "redirects to the spree_appointment" do
  #       appointment = Spree::Appointment.create! valid_attributes
  #       put :update, {:id => appointment.to_param, :spree_appointment => valid_attributes}, valid_session
  #       expect(response).to redirect_to(appointment)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the spree_appointment as @spree_appointment" do
  #       appointment = Spree::Appointment.create! valid_attributes
  #       put :update, {:id => appointment.to_param, :spree_appointment => invalid_attributes}, valid_session
  #       expect(assigns(:spree_appointment)).to eq(appointment)
  #     end

  #     it "re-renders the 'edit' template" do
  #       appointment = Spree::Appointment.create! valid_attributes
  #       put :update, {:id => appointment.to_param, :spree_appointment => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end

  describe "DELETE destroy" do
    it "destroys the requested spree_appointment" do
      appointment = Spree::Appointment.create! valid_attributes
      expect {
        delete :destroy, {:id => appointment.to_param}, valid_session
      }.to change(Spree::Appointment, :count).by(-1)
    end

    it "redirects to the spree_appointments list" do
      appointment = Spree::Appointment.create! valid_attributes
      delete :destroy, {:id => appointment.to_param}, valid_session
      expect(response).to redirect_to(spree_appointments_url)
    end
  end

end
