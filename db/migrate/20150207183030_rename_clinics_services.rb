class RenameClinicsServices < ActiveRecord::Migration
  def change
    rename_table :clinics_services, :spree_clinics_services
  end
end
