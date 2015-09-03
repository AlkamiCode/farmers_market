require 'rails_helper'
require 'factory_helper'

RSpec.describe Admin::StoresController, type: :controller do

  before do
    build_farms
    @user_one.roles << Role.find_or_create_by(name: "store_admin")
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(@user_one)
  end

  it 'GET #edit' do
    get 'edit', :store => @user_one.store.url
    expect(response).to be_success
  end
end
