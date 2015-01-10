require 'rails_helper'

describe Spree::User do

  context 'role is present' do
    it 'becomes a doctor if asked to' do
      user = Spree::User.new email: 'test@test.com', password: 'secret'
      user.make_role = 'doctor'
      # byebug
      # if user.make_role and Spree::Role::CIVIL_ROLES.include? user.make_role
        # user.spree_roles << Spree::Role.doctor
        # puts 'SHIHHIT'
      # end

      user.save
      # puts user.spree_roles.inspect
      # puts user.spree_roles.where(name: 'doctor').inspect
      # user.has_spree_role? 'doctor'
      # puts user.has_spree_role? 'doctor'
      expect(user).to have_spree_role Spree::Role.doctor.name
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
