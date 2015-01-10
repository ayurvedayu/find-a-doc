class CreateSpreeDoctors < ActiveRecord::Migration
  def change
    create_table :spree_doctors do |t|
      t.belongs_to :clinic, index: true
      t.belongs_to :user, index: true
      t.string :name
      t.text :description
      t.text :phone
      t.boolean :is_for_instance_booking

      t.timestamps
    end
  end
end
