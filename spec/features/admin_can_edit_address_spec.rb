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

  scenario "Admin logs in and views edit address form" do
    click_link "Login"

    fill_in "Email", with: "amaluna@cds.com"
    fill_in "Password", with: "password"
    click_button "Login"

    click_link "Admin Dashboard"
    expect(current_path).to eq("/admin/amaluna-farms/dashboard")

    click_link "Edit Farm Address"
    expect(current_path).to eq("/admin/amaluna-farms/addresses")
  end

  scenario "Admin logs in and views edit form" do
    click_link "Login"

    fill_in "Email", with: "amaluna@cds.com"
    fill_in "Password", with: "password"
    click_button "Login"

    click_link "Admin Dashboard"
    expect(current_path).to eq("/admin/amaluna-farms/dashboard")

    click_link "Edit Farm Address"
    expect(current_path).to eq("/admin/amaluna-farms/addresses")

    within(".well") do
      expect(find_field("address_address_1").value).to eq("123 Sesame St")
      expect(find_field("address_address_2").value).to eq("Apt 123")
      expect(find_field("address_city").value).to eq("New York")
      expect(find_field("address_state").value).to eq("NY")
      expect(find_field("address_zip_code").value).to eq("12345")
    end
  end

  scenario "updates store info" do
    click_link "Login"

    fill_in "Email", with: "amaluna@cds.com"
    fill_in "Password", with: "password"
    click_button "Login"

    click_link "Admin Dashboard"
    expect(current_path).to eq("/admin/amaluna-farms/dashboard")

    click_link "Edit Farm Address"
    expect(current_path).to eq("/admin/amaluna-farms/addresses")

    find('input[type="text"][name*="address[address_1]"]').set("1 Billing Address Way")
    find('input[type="text"][name*="address[address_2]"]').set("Unit 2")
    find('input[type="text"][name*="address[city]"]').set("Arlington")
    find('input[type="text"][name*="address[state]"]').set("TX")
    find('input[type="text"][name*="address[zip_code]"]').set("76014")

    click_button "Edit Address"

    expect(current_path).to eq("/admin/amaluna-farms/dashboard")

    within(".alert-success") do
      expect(page).to have_content("Your farm address has been updated")
    end

    expect(page).to have_content("1 Billing Address Way")
    expect(page).to have_content("Unit 2")
    expect(page).to have_content("Arlington")
    expect(page).to have_content("TX")
    expect(page).to have_content("76014")
  end

  scenario "can not update store address" do
    click_link "Login"

    fill_in "Email", with: "amaluna@cds.com"
    fill_in "Password", with: "password"
    click_button "Login"

    click_link "Admin Dashboard"
    expect(current_path).to eq("/admin/amaluna-farms/dashboard")

    click_link "Edit Farm Address"
    expect(current_path).to eq("/admin/amaluna-farms/addresses")

    find('input[type="text"][name*="address[address_1]"]').set("1 Billing Address Way")
    find('input[type="text"][name*="address[address_2]"]').set("Unit 2")
    find('input[type="text"][name*="address[city]"]').set("Arlington")
    find('input[type="text"][name*="address[state]"]').set("TX")
    find('input[type="text"][name*="address[zip_code]"]').set("Hello World")

    click_button "Edit Address"

    expect(current_path).to eq("/admin/amaluna-farms/addresses")

    within(".alert-warning") do
      expect(page).to have_content("Zip code is not a number. Zip code is too long (maximum is 9 characters)")
    end
  end
end
