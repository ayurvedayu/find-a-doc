Spree::Role.class_eval do
  CIVIL_ROLES = %w(user doctor clinic)
  def self.doctor
    find_or_create_by(name: "doctor")
  end

  def self.clinic
    find_or_create_by(name: "clinic")
  end
end

