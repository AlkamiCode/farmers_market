class ChangePhotosColumnInStoresTable < ActiveRecord::Migration
  def change
    rename_column :stores, :photo, :photo_url
  end
end
