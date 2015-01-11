Spree::User.class_eval do
  attr_accessor :make_role

  before_create :update_role

  has_one :doctor

  def doctor?
    has_spree_role? 'doctor'
  end

  def clinic?
    has_spree_role? 'clinic'
  end

  def make_clinic
    self.spree_roles << Spree::Role.clinic
  end

  def revoke_clinic
    self.spree_roles.delete Spree::Role.clinic
  end

  def make_doctor
    self.spree_roles << Spree::Role.doctor
    self.doctor = Spree::Doctor.create
  end

  def revoke_doctor
    self.spree_roles.delete Spree::Role.doctor
    # TODO remove associated doctor
  end

  def update_role
    if make_role and Spree::Role::CIVIL_ROLES.include? make_role
      send("make_#{make_role}")
    end
  end
end

