class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:edit, :update]

  def index
    @products = current_store.products
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_store.products.new(product_params)
    if @product.save
      flash[:success] = "#{@product.name} has been added."
      redirect_to admin_dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @product.update(product_params)
    flash[:success] = "#{@product.name} has been updated."
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name,
                                    :description,
                                    :price,
                                    :image_url,
                                    :category_id,
                                    :status,
                                    :store)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
