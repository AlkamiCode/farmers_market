class Stores::ProductsController < ApplicationController
  def index
    @farmer = Store.find_by(url: params[:store])
  end
end
