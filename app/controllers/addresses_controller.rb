class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    user = User.find(current_user.id)
    @address = user.addresses.new(address_params)
    check_for_create
  end

  def edit
    @address = current_user.addresses.first
  end

  def update
    @address = Address.find(params[:id])
    check_for_update
  end

  private

  def check_for_create
    if @address.save
      flash[:success] = "Address created."
      redirect_to account_edit_path
    else
      flash.now[:warning] = @address.errors.full_messages.join(". ")
      render :new
    end
  end

  def check_for_update
    if @address.update(address_params) && current_store
      flash[:success] = "Your farm address has been updated."
      redirect_to admin_dashboard_path(current_store)
    elsif @address.update(address_params)
      flash[:success] = "Your address has been updated."
      redirect_to account_edit_path
    else
      flash[:warning] = @address.errors.full_messages.join(". ")
      redirect_to account_edit_path
    end
  end

  def address_params
    params.require(:address)
    .permit(:type_of, :address_1, :address_2, :city, :state, :zip_code)
  end
end
