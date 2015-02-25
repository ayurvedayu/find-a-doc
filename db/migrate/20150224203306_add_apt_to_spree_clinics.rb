class AddAptToSpreeClinics < ActiveRecord::Migration
  def change
    add_column :spree_clinics, :is_for_instant_booking, :boolean
    add_column :spree_clinics, :phone, :string
  end
end
