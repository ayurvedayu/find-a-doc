class CreateSpreeClinicTypes < ActiveRecord::Migration
  def change
    create_table :spree_clinic_types do |t|
      t.string :name

      t.timestamps
    end
    Spree::ClinicType.create name: 'Ayurveda'
    Spree::ClinicType.create name: 'Dental'
  end
end
