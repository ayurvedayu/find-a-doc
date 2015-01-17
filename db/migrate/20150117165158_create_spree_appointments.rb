class CreateSpreeAppointments < ActiveRecord::Migration
  def change
    create_table :spree_appointments do |t|
      t.belongs_to :doctor_employment
      t.belongs_to :user
      t.integer :status
      t.string :name
      t.string :phone
      t.string :address
      t.string :email
      t.text :cause
      t.integer :payment

      t.timestamps
    end
  end
end
