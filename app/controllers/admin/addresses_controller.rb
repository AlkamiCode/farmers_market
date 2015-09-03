class Admin::AddressesController < Admin::BaseController
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      @address.type_of = "farm"
      current_user.addresses << @address
      flash[:success] = "#{Store.last.farm_name}, your address has been saved."
      redirect_to admin_dashboard_path(current_store)
    else
      flash[:danger] = "Please try again!"
      render :new
    end
  end

  def edit
    @address = current_user.addresses.select{|address| address.type_of == "farm"}
  end

  def update
    @address = current_user.addresses

    if @address.update(address_params)
      flash[:success] = "Your farm address has been updated."
      redirect_to admin_dashboard_path(current_store)
    else
      flash[:warning] = @address.errors.full_messages.join(". ")
      redirect_to "/admin/#{current_store.url/addresses}"
    end
  end

  private

  def address_params
    params.require(:address)
          .permit(:type_of, :address_1, :address_2, :city, :state, :zip_code)
  end
end
