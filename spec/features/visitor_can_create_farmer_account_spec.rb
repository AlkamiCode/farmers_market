require "rails_helper"

feature "a visitor can create a farmer account" do
  before do
    visit root_path
    click_link "Join Today!"
  end

  scenario "a visitor clicks on the create a farmer account button and" \
    " sees create account form" do
    expect(current_path).to eq "/store/account/new"
    expect(page).to have_content("First Name")
    expect(page).to have_content("Last Name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Create Account")
  end

  scenario "a vistor fills out and submits a valid create account form, fills" \
    " out farm profile and farm address page" do
    fill_in "First Name", with: "Jane"
    fill_in "Last Name", with: "Doe"
    fill_in "Email", with: "jane@doe.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    expect(User.all.last.email).to eq "jane@doe.com"
    expect(User.all.last.roles.first.name).to eq("store_admin")
    expect(current_path).to eq store_profile_new_path
    within(".alert-success") do
      expect(page).to have_content("Welcome to Farmers Market, Jane Doe!")
    end
    within(".navbar-right") do
      expect(page).to have_content("Logged in as Jane Doe")
    end
    expect(page).to have_content("Jane")
    expect(page).to have_content("Doe")
    expect(page).to_not have_content("Login")
    expect(page).to have_content("Logout")

    expect(page).to have_content("Farm Name")
    expect(page).to have_content("About your Farm")
    expect(page).to have_content("Facebook Url")
    expect(page).to have_content("Twitter Url")
    expect(page).to have_content("Instagram Url")
    expect(page).to have_button("Create Profile")

    fill_in "Farm Name", with: "Jane Farm"
    fill_in "About your Farm", with: "The happiest farm on earth."
    fill_in "Facebook Url", with: "facebook.com"
    fill_in "Twitter Url", with: "twitter.com"
    fill_in "Instagram Url", with: "instagram.com"
    click_button "Create Profile"

    expect(current_path).to eq("/admin/jane-farm/addresses/new")
    within(".alert-success") do
      expect(page).to have_content("Welcome to Farmers Market, Jane Farm!")
    end

    find('input[type="text"][name*="address[address_1]"]').set("1 Billing Address Way")
    find('input[type="text"][name*="address[address_2]"]').set("Unit 2")
    find('input[type="text"][name*="address[city]"]').set("Arlington")
    find('input[type="text"][name*="address[state]"]').set("TX")
    find('input[type="text"][name*="address[zip_code]"]').set("76014")
    click_button "Add Address"

    expect(current_path).to eq root_path
  end
end
