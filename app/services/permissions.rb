class Permissions
  attr_reader :user,
  :controller,
  :action

  def initialize(user)
    @user = user
  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    if user && user.store_admin?
      store_admin_permissions
    elsif user && user.registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  private

  def registered_user_permissions
    return true if controller == "stores" && action.in?(%w(index show new))
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "static_pages" && action == 'index'
    return true if controller == "cart_items" && action.in?(%w(index create update destroy))
    return true if controller == "stores/products" && action.in?(%w(index))
    return true if controller == "products" && action.in?(%w(index show))
    return true if controller == "categories" && action == "show"
    return true if controller == "addresses" && action.in?(%w(new create edit update))
    return true if controller == "users" && action.in?(%w(show edit update))
    return true if controller == "orders" && action.in?(%w(show create))
    return true if controller == "charges" && action.in?(%w(create))
  end

  def guest_user_permissions
    return true if controller == "stores" && action.in?(%w(index show))
    return true if controller == "sessions" && action.in?(%w(new create))
    return true if controller == "static_pages" && action == 'index'
    return true if controller == "cart_items" && action.in?(%w(index create update destroy))
    return true if controller == "products" && action.in?(%w(index show))
    return true if controller == "categories" && action == "show"
    return true if controller == 'users' && action.in?(%w(new create update))
    return true if controller == "stores/products" && action.in?(%w(index))
    return true if controller == "store/profile/new" && action.in?(%w(new create))
  end

  def store_admin_permissions
    return true if controller == "stores" && action.in?(%w(index show))
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "products" && action.in?(%w(index show create update))
    return true if controller == "orders" && action.in?(%w(index show update index_ordered index_paid index_cancelled index_completed))
    return true if controller == "users" && action.in?(%w(index show))
    return true if controller == "static_pages" && action == 'index'
    return true if controller == "cart_items" && action.in?(%w(index create update destroy))
    return true if controller == "admin/stores" && action == "index"
    return true if controller == "products" && action.in?(%w(index show))
    return true if controller == "categories" && action == "show"
    return true if controller == "stores/products" && action.in?(%w(index))
    return true if controller == "stores" && action.in?(%w(new create update edit))
    return true if controller == "admin/addresses" && action.in?(%w(new create update edit))
    return true if controller == "addresses" && action.in?(%w(update edit))
    return true if controller == "admin/stores" && action.in?(%w(update edit))
    return true if controller == "addresses" && action.in?(%w(new create))
    return true if controller == "admin/admins" && action.in?(%w(show))
    return true if controller == "admin/products" && action.in?(%w(index new edit update create))
    return true if controller == "admin/orders" && action.in?(%w(index show update))
  end

  def platform_admin_permissions #needs build out
    return true if controller == "stores" && action.in?(%w(index show))
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "products" && action.in?(%w(index show create update))
    return true if controller == "orders" && action.in?(%w(index show update index_ordered index_paid index_cancelled index_completed))
    return true if controller == "users" && action == 'index'
    return true if controller == "static_pages" && action == 'index'
    return true if controller == "cart_items" && action.in?(%w(index create update destroy))
    return true if controller == "products" && action.in?(%w(index show))
    return true if controller == "categories" && action == "show"
    return true if controller == "stores/products" && action.in?(%w(index))
  end
end
