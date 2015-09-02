require "rails_helper"
require "factory_helper"

feature "Admin can edit Farm Profile" do
  before do
    @user_one = User.create(
    email: "amaluna@cds.com",
    password: "password",
    first_name: "Ama",
    last_name: "Luna"
    )

    @user_one.roles << Role.find_or_create_by(name: "store_admin")

    store_one = Store.create(
    id: 1,
    farm_name: "Amaluna Farms",
    facebook_url: "www.facebook.com",
    photo_url: "farmers/amish-hay.jpg",
    twitter_url: "www.twitter.com",
    instagram_url: "www.instagram.com",
    description: "French Farm Fresh Food served by acrobats in tights.  How much more French can you get?",
    url: "amaluna-farms",
    user_id: @user_one.id
    )

    @user_one.addresses.create(type_of:   2,
    address_1: "123 Sesame St",
    address_2: "Apt 123",
    city:      "New York",
    state:     "NY",
    zip_code:  "12345")

    visit root_path
    visit admin_dashboard_path(@user_one.store)
  end

  scenario "Admin logs in and views edit form" do
    click_link "Login"

    fill_in "Email", with: "amaluna@cds.com"
    fill_in "Password", with: "password"
    click_button "Login"

    click_link "Admin Dashboard"
    expect(current_path).to eq("/admin/amaluna-farms/dashboard")

    click_link "Edit Farm Profile"
    expect(current_path).to eq("/admin/amaluna-farms/profile/edit")
  end

  scenario "Admin logs in and views edit form" do
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(@user_one)
    page.set_rack_session(user_id: @user_one.id)

    visit admin_stores_edit_path(@user_one.store)

    within(".well") do
      expect(find_field("store[farm_name]").value).to eq("Amaluna Farms")
      expect(find_field("store[description]").value.first).to eq("F")
      expect(find_field("store[facebook_url]").value).to eq("www.facebook.com")
    end
  end

  scenario "updates store Info" do
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(@user_one)
    page.set_rack_session(user_id: @user_one.id)

    visit admin_stores_edit_path(@user_one.store)

    fill_in "store[farm_name]", with: "new farm"
    fill_in "store[facebook_url]", with: "myspace.com"
    click_button "Update Profile"

    expect(current_path).to eq("/admin/new-farm/dashboard")

    expect(Store.last.farm_name).to eq("new farm")
  end
end
