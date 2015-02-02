class AddStatusToSpreeDoctorEmployments < ActiveRecord::Migration
  def change
    add_column :spree_doctor_employments, :status, :integer
  end
end
