require 'rails_helper'

describe Spree::User do

  context 'role is present' do
    it 'becomes a doctor if make_role attr is set to doctor' do
      user = Spree::User.new email: 'test@test.com', password: 'secret'
      user.make_role = 'doctor'
      

      user.save
      

      expect(user).to have_spree_role Spree::Role.doctor.name

      expect(user.doctor).to be_present
    end

    it 'tells it\'s role correctly' do
      user = Spree::User.new email: 'test@test.com', password: 'secret'
      user.make_doctor

      user.save

      expect(user).to be_doctor

      user.make_clinic

      expect(user).to be_clinic
    end
  end
end
