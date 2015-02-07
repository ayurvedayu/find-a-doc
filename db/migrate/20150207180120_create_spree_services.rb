class CreateSpreeServices < ActiveRecord::Migration
  def change
    create_table :spree_services do |t|
      t.string :name

      t.timestamps
    end
    create_table :clinics_services, id: false do |t|
      t.belongs_to :clinic, index: true
      t.belongs_to :service, index: true
    end
  end
end
