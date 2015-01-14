class ChangeLatAndLonToFloat < ActiveRecord::Migration
  def change
    change_column :spree_clinics, :latitude, 'float USING CAST(latitude AS float)'
    change_column :spree_clinics, :longitude, 'float USING CAST(latitude AS float)'
  end
end
