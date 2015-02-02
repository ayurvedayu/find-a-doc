class AddDegreeToSpreeDoctors < ActiveRecord::Migration
  def change
    add_column :spree_doctors, :degree, :string
  end
end
