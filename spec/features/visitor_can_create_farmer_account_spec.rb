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

  xscenario "a vistor fills out and submits a valid create account form" do
    fill_in "First Name", with: "Jane"
    fill_in "Last Name", with: "Doe"
    fill_in "Email", with: "jane@doe.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    expect(User.all.last.email).to eq "jane@doe.com"

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
  end
end
