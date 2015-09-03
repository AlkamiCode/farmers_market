require "rails_helper"
require 'factory_helper'

feature "Admin can view Admin Dashboard" do

  before do
    build_farms
    @user_one.roles << Role.find_or_create_by(name: "store_admin")
  end
  scenario "Admin logs in and sees Admin Dashboard for /admin/dashboard" do
    visit login_path

    fill_in "Email", with: "amaluna@cds.com"
    fill_in "Password", with: "password"
    click_button "Login"


    expect(current_path).to eq(admin_dashboard_path(@user_one.store))
  end

  scenario "Non-admin logs in and is redirected to landing page" do
    user = User.create(first_name: "Jane",
                last_name: "Doe",
                email: "jane@doe.com",
                password: "password",
                )

    role = Role.create(name: "registered_user")

    user.roles << role

    visit login_path

    fill_in "Email", with: "jane@doe.com"
    fill_in "Password", with: "password"
    click_button "Login"

    visit admin_dashboard_path(@user_one.store)

    expect(current_path).to eq("/")
  end

  scenario "Non-user is also redirected to landing page" do
    visit admin_dashboard_path(@user_one.store)

    expect(current_path).to eq("/")
  end
end
