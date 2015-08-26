class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :farm_name
      t.string :facebook_url
      t.string :photo
      t.string :twitter_url
      t.string :instagram_url
      t.string :description
      t.string :url
    end
  end
end
