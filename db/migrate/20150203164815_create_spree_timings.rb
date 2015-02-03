class CreateSpreeTimings < ActiveRecord::Migration
  def change
    create_table :spree_timings do |t|
      t.references :timeslotable, polymorphic: true, index: true
      t.integer :day
      t.string :start_time
      t.string :end_time

      t.timestamps null: false
    end
  end
end
