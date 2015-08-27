class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize!

  helper_method :current_user, :current_admin?, :cart, :current_store

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= Permissions.new(current_user)
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_store
    @current_store ||= Store.find_by(url: current_user.store.url)
  end

  def authorize!
      redirect_to root_path, danger: "Not Allowed" unless authorized?
  end

  def load_featured_products
    @featured_products = Product.limit(6).order("RANDOM()")
  end

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  private

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end
end
