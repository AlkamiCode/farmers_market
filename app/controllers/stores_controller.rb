class StoresController < ApplicationController
  def index
    if params[:format]
      category = Category.find_by(slug: params[:format])
      @stores = category.stores.uniq
    else
      @stores = Store.all
    end
  end

  def show

  end
end
