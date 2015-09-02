class ChangeTypeOnProductsTable < ActiveRecord::Migration
  def up
    change_column :products, :image_url, :string
  end

  def down
    change_column :products, :image_url, :text
  end
end
