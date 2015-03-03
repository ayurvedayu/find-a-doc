class AddExperienceYearsToSpreeDoctors < ActiveRecord::Migration
  def change
    add_column :spree_doctors, :experience_years, :integer
  end
end
