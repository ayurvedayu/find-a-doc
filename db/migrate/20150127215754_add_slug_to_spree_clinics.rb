class AddSlugToSpreeClinics < ActiveRecord::Migration
  def change
    add_column :spree_clinics, :slug, :string
    add_index :spree_clinics, :slug, unique: true
  end
end
