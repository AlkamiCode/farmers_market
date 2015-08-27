class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def show

  end
end
