class AddNameToSpreeClinics < ActiveRecord::Migration
  def change
    add_column :spree_clinics, :name, :text
  end
end
