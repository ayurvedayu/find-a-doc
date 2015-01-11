class AddDefaultValueToIsForInstantBookingAttribute < ActiveRecord::Migration
  def change
    rename_column :spree_doctors, :is_for_instance_booking, :is_for_instant_booking
    change_column :spree_doctors, :is_for_instant_booking, :boolean, :default => false
  end
end
