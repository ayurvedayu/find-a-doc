class AddAutoConfirmableToSpreeDoctors < ActiveRecord::Migration
  def change
    add_column :spree_doctors, :auto_confirmable, :boolean, default: true
  end
end
