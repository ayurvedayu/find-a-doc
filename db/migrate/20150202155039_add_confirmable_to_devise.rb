class AddConfirmableToDevise < ActiveRecord::Migration
  def change
    add_column :spree_users, :confirmation_token, :string
    add_column :spree_users, :confirmed_at, :datetime
    add_column :spree_users, :confirmation_sent_at, :datetime
    # add_column :spree_users, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :spree_users, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    Spree::User.update_all(:confirmed_at => Time.now)
    # All existing user accounts should be able to log in after this.
  end
end
