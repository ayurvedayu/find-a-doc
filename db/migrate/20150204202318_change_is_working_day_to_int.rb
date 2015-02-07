class ChangeIsWorkingDayToInt < ActiveRecord::Migration
  def change
    remove_column :spree_timings, :is_working_day
    add_column :spree_timings, :is_working_day, :integer, default: 0
  end
end
