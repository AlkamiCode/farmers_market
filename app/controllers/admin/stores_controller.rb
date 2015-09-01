class Admin::StoresController < Admin::BaseController
  def index

  end

  def edit
    @store = Store.find_by(url: params[:store])
  end

  def update
    @store = Store.find_by(url: params[:store])
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
