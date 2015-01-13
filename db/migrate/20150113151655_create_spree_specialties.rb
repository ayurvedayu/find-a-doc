class CreateSpreeSpecialties < ActiveRecord::Migration
  def change
    create_table :spree_specialties do |t|
      t.string :name

      t.timestamps
    end

    create_table :spree_doctors_specialties, id: false do |t|
      t.belongs_to :doctor, index: true
      t.belongs_to :specialty, index: true
    end

    Spree::Specialty.create 'Ayurveda'
    Spree::Specialty.create 'Dentist'
  end
end
