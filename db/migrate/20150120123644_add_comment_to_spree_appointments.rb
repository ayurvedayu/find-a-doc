class AddCommentToSpreeAppointments < ActiveRecord::Migration
  def change
    add_column :spree_appointments, :comment, :text
  end
end
