require 'rails_helper'

describe OrdersController do
  before do
    @admin = User.create(first_name: "Mike",
    last_name: "Dorrance",
    email: "mike@mike.com",
    password: "12345678",)
    @admin.roles << Role.find_or_create_by(name: "store_admin")

    @admin.store = Store.create(farm_name: "Carmer's Ranch", facebook_url: "https://www.facebook.com/turingschool",
    instagram_url: "https://instagram.com/", twitter_url: "twitter.com",
    description: "Here at the Carmer Ranch, we have lots of food...and chickens.")

  end

  describe 'controller can get #index' do
    before do
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(@admin)
      get :index
    end
    it { is_expected.to respond_with :ok }
    it { is_expected.to respond_with_content_type :html }
    it { is_expected.to render_with_layout :application }
    it { is_expected.to render_template :index }
  end
end
