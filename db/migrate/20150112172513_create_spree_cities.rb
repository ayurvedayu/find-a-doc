class CreateSpreeCities < ActiveRecord::Migration
  def change
    create_table :spree_cities do |t|
      t.string :name

      t.timestamps
    end

    # run 'bundle exec rake db:seed_geoobjects'
  end
end
