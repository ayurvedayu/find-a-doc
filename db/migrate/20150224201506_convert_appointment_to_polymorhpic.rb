class ConvertAppointmentToPolymorhpic < ActiveRecord::Migration
  def change
    rename_column :spree_appointments, :doctor_employment_id, :appointmentable_id
    add_column :spree_appointments, :appointmentable_type, :string

    Spree::Appointment.update_all appointmentable_type: 'Spree::DoctorEmployment'

    add_index :spree_appointments, [:appointmentable_id, :appointmentable_type], name: 'appointmentable'
  end
end
