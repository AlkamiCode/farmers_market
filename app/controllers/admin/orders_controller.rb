class Admin::OrdersController < Admin::BaseController
  def index
    @orders = current_store.get_orders.paginate(page: params[:page], per_page: 15)
    @status = :all
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.status = params[:status]
    order.save
    redirect_to admin_orders_path(current_store)
  end
end
