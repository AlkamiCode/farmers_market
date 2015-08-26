class CategoryStore < ActiveRecord::Base
  belongs_to :store
  belongs_to :category
end
