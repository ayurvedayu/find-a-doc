class CreateSpreeRecommendations < ActiveRecord::Migration
  def change
    create_table :spree_recommendations do |t|
      t.belongs_to :doctor, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
