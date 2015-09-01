class StaticPagesController < ApplicationController
  def index
    load_featured_products
    @featured_farmer = Store.last
  end
end
