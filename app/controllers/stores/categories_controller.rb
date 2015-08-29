class Stores::CategoriesController < ApplicationController
  def index

  end

  def show
    byebug
    @category = Category.find_by(slug: params[:slug])
  end
end
