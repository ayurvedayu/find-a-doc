class AddIsWorkingDayToSpreeTimings < ActiveRecord::Migration
  def change
    add_column :spree_timings, :is_working_day, :boolean, default: false
  end
end
