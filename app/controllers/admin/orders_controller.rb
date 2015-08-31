class Admin::OrdersController < Admin::BaseController
  def index
    @orders = current_store.get_orders.paginate(page: params[:page], per_page: 15)
    @status = :all
  end

  def index_ordered
    @orders = current_store.get_orders
    @status = :ordered
    render :index
  end

  def index_paid
    @orders = current_store.get_orders
    @status = :paid
    render :index
  end

  def index_cancelled
    @orders = current_store.get_orders
    @status = :cancelled
    render :index
  end

  def index_completed
    @orders = current_store.get_orders
    @status = :completed
    render :index
  end

  def show
    @order = Order.find(params[:id])

    # capability = Twilio::Util::Capability.new ENV["twilio_account_sid"], ENV["twilio_auth_token"]
    # capability.allow_client_outgoing ENV["twilio_twiml_app_sid"]
    # @token = capability.generate
  end

  def update
    order = Order.find(params[:id])
    order.status = params[:status]
    order.save
    redirect_to admin_orders_path
  end
end
