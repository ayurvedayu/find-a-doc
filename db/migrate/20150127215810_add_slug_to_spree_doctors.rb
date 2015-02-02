class AddSlugToSpreeDoctors < ActiveRecord::Migration
  def change
    add_column :spree_doctors, :slug, :string
    add_index :spree_doctors, :slug, unique: true
  end
end
