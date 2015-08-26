class Store < ActiveRecord::Base
  belongs_to :user
  has_many :products
  has_many :category_stores
  has_many :categories, through: :category_stores
end
