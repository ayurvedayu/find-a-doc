class ChangeLatAndLonToFloat < ActiveRecord::Migration
  def change
    change_column :spree_clinics, :latitude, :float 
    change_column :spree_clinics, :longitude, :float 
  end
end
