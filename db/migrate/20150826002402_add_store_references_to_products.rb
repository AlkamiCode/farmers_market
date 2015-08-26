class AddStoreReferencesToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :store, index: true, foreign_key: true
  end
end
