require "rails_helper"

feature "an admin can create products" do
  before do
    @admin = User.create(first_name: "Mike",
                        last_name: "Dorrance",
                        email: "mike@mike.com",
                        password: "12345678",)
    @admin.roles << Role.find_or_create_by(name: "store_admin")

    @admin.store = Store.create(farm_name: "Carmer's Ranch", facebook_url: "https://www.facebook.com/turingschool",
    instagram_url: "https://instagram.com/", twitter_url: "twitter.com",
    description: "Here at the Carmer Ranch, we have lots of food...and chickens.")

    visit root_path

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(@admin)

    Category.create(name: "Canned Goods",
                    description: "Food descriptions",
                    slug: "canned")
    Category.create(name: "Baked Goods",
                    description: "Food category description",
                    slug: "food")

    visit admin_dashboard_path(@admin.store)

    click_link "View All Products"
    click_link "Add New Product"
  end

  scenario "admin visits admin/product/new and sees Add Product Form" do
    expect(page).to have_content("Add a New Product")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Price")
    expect(page).to have_content("Category")
    expect(page).to have_content("Status")
    expect(page).to have_button("Add Product")
  end

  scenario "admin can create a new Product" do
    fill_in "Name", with: "Baked Beans"
    fill_in "Description", with: "Yum"
    fill_in "Price", with: "12.99"
    select "Baked Goods", from: "product[category_id]"
    select "Active", from: "product[status]"
    click_button "Add Product"

    within(".alert-success") do
      expect(page).to have_content("Baked Beans has been added.")
    end
    expect(current_path).to eq(admin_dashboard_path(@admin.store))
  end
end
