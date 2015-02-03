class CreateSpreeVerifications < ActiveRecord::Migration
  def change
    create_table :spree_verifications do |t|
      t.belongs_to :user, index: true
      t.string :token
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
