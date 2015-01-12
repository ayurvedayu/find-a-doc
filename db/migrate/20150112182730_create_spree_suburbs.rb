class CreateSpreeSuburbs < ActiveRecord::Migration
  def change
    create_table :spree_suburbs do |t|
      t.string :name
      t.belongs_to :city, index: true

      t.timestamps
    end
  end
end
