require "rails_helper"

feature "a user can login" do
  scenario "an existing user logs in" do
    User.create(
        email: "amaluna@cds.com",
        password: "password",
        first_name: "Ama",
        last_name: "Luna")

    visit root_path
    click_link "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Welcome Back to Farmers Market!")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Login")

    fill_in "Email", with: "amaluna@cds.com"
    fill_in "Password", with: "password"
    click_button "Login"

    expect(current_path).to eq(root_path)
    within(".alert-success") do
      expect(page).to have_content("Welcome back to Farmer Market, Ama Luna!")

    end
    within(".navbar-right") do
      expect(page).to have_link("Logged in as Ama Luna")
    end
    expect(page).to have_content("Ama")
    expect(page).to have_content("Luna")
    expect(page).to have_content("Ama Luna")
    expect(page).to_not have_content("Login")
    expect(page).to have_content("Logout")
  end

  scenario "a visitor without an account can not login" do
    visit root_path
    click_link "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Welcome Back to Farmers Market!")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Login")

    fill_in "Email", with: "jane@doe.com"
    fill_in "Password", with: "12345678"
    click_button "Login"

    expect(current_path).to eq(login_path)
    within(".alert-warning") do
      expect(page).to have_content("Unable to Login with this Email and" \
        " Password combination.")
    end
    within(".navbar-right") do
      expect(page).to_not have_content("Logged in as Jane Doe")
    end
    expect(page).to_not have_content("Jane")
    expect(page).to_not have_content("Doe")
    expect(page).to_not have_content("jane@doe.com")
    expect(page).to have_content("Create Account")
    expect(page).to have_content("Login")
  end
end
