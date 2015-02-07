class ChangeVerificationsToPolymorhpic < ActiveRecord::Migration
  def change
    change_table :spree_verifications do |t|
      t.remove :user_id
      t.references :verifiable, polymorphic: true
    end

    add_index :spree_verifications, :verifiable_id
  end
end
