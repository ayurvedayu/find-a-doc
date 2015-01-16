class CreateSpreeClinics < ActiveRecord::Migration
  def change
    create_table :spree_clinics do |t|
      t.belongs_to :suburb, index: true
      t.belongs_to :user, index: true
      t.float :latitude
      t.float :longitude
      t.text :description
      t.belongs_to :clinic_type, index: true
      t.string :street
      t.string :building

      t.timestamps
    end
  end
end
