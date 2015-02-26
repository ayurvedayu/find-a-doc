class AddAutoConfirmableToSpreeClinics < ActiveRecord::Migration
  def change
    add_column :spree_clinics, :auto_confirmable, :boolean, default: true
  end
end
