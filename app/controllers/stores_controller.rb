class StoresController < ApplicationController
  def index
    if params[:format]
      category = Category.find_by(slug: params[:format])
      @stores = category.stores.uniq
    else
      @stores = Store.all
    end
  end

  def show
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      current_user.store = @store
      flash[:success] = "Welcome to Farmers Market," \
        " #{@store.farm_name}!"
      NotificationsMailer.new_store(current_user).deliver_now
      redirect_to "/admin/#{@store.url}/addresses/new"
    else
      flash[:danger] = "Please try again!"
      render :new
    end
  end

  def edit
    @store = Store.find_by(url: params[:store])
  end

  def update
    @store = current_store
    @store.update(store_params)
    flash[:success] = "#{@store.farm_name} has been updated."
    redirect_to admin_dashboard_path(@store.farm_name)
  end

  private

  def store_params
    params.require(:store)
          .permit(:farm_name, :facebook_url, :twitter_url, :instagram_url, :description, :photo_url)
  end
end
