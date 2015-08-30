class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: "/public/404" unless current_store_admin? || current_platform_admin?

  end
end
