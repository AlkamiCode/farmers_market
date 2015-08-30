class Admin::AdminsController < Admin::BaseController
  def show
    @product = Product.new
  end
end
