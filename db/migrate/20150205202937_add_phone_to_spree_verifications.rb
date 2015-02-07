class AddPhoneToSpreeVerifications < ActiveRecord::Migration
  def change
    add_column :spree_verifications, :phone, :string
  end
end
