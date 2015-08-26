class CreateCategoryStores < ActiveRecord::Migration
  def change
    create_table :category_stores do |t|
      t.references :store, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
    end
  end
end
