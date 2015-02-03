class AddPhoneIsVerifiedToSpreeDoctors < ActiveRecord::Migration
  def change
    add_column :spree_doctors, :phone_is_verified, :boolean
  end
end
