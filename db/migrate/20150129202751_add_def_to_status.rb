class AddDefToStatus < ActiveRecord::Migration
  def change
    change_column :spree_doctor_employments, :status, :integer, default: 0
  end
end
