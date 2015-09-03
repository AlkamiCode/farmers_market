module ApplicationHelper
   def registered_user?
     current_user && current_user.registered_user?
   end

  def store_admin?
    current_user && current_user.store_admin?
  end

  def platform_admin?
    current_user && current_user.platform_admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
