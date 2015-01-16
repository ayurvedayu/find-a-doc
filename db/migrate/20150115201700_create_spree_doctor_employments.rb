class CreateSpreeDoctorEmployments < ActiveRecord::Migration
  def change
    create_table :spree_doctor_employments do |t|
      t.belongs_to :doctor, index: true
      t.belongs_to :clinic, index: true
      t.float :consultation_price
      t.string :consultation_currency

      t.timestamps
    end
  end
end
