class CreateSpreeExperiences < ActiveRecord::Migration
  def change
    create_table :spree_experiences do |t|
      t.belongs_to :doctor, index: true
      t.integer :start_year
      t.integer :end_year
      t.string :place

      t.timestamps
    end
  end
end
