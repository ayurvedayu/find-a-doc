class CreateSpreeReviews < ActiveRecord::Migration
  def change
    create_table :spree_reviews do |t|
      t.belongs_to :doctor, index: true
      t.belongs_to :user, index: true
      t.text :text
      t.integer :status

      t.timestamps
    end
  end
end
