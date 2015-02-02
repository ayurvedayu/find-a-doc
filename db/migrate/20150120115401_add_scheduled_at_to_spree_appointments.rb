class AddScheduledAtToSpreeAppointments < ActiveRecord::Migration
  def change
    add_column :spree_appointments, :scheduled_at, :datetime
  end
end
