class AddPhoneIsVerifiedToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :phone_is_verified, :boolean, default: false
  end
end
