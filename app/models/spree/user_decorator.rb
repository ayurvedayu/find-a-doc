Spree::User.class_eval do
  attr_accessor :make_role

  before_create :update_role

  def make_clinic
    self.spree_roles << Spree::Role.clinic
  end

  def revoke_clinic
    self.spree_roles.delete Spree::Role.clinic
  end

  def make_doctor
    self.spree_roles << Spree::Role.doctor
  end

  def revoke_doctor
    self.spree_roles.delete Spree::Role.doctor
  end

  def update_role
    if make_role and Spree::Role::CIVIL_ROLES.include? make_role
      send("make_#{make_role}")
    end
  end
end