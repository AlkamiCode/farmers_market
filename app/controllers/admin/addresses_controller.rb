class Admin::AddressesController < Admin::BaseController
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      current_store.address = @address
      @address.type_of = "farm"
      flash[:success] = "#{Store.last.farm_name}, your address has been saved."
      redirect_to root_path

    else
      flash[:danger] = "Please try again!"
      render :new
    end
  end

  private

  def address_params
    params.require(:address)
          .permit(:type_of, :address_1, :address_2, :city, :state, :zip_code)
  end
end
