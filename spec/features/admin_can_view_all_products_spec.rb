require "rails_helper"
require "factory_helper"

feature "Admin can view all Products from Admin Dashboard" do
  before do
    build_products
    build_farms
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(@user_one)

    visit admin_dashboard_path(@user_one.store)
  end

  scenario "Admin logs in and sees View All Products button" do
    expect(page).to have_content("View All Products")
  end

  scenario "Admin clicks on View All Products and sees all products" do
    product1 = Product.first
    @user_one.store.products << product1
    click_link "View All Products"

    expect(current_path).to eq(admin_products_path(@user_one.store))
    expect(page).to have_content("All Products")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Price")
    expect(page).to have_content("Category")
    expect(page).to have_content("Status")

    within("tr", text: product1.name) do
      expect(page).to have_content("Fruit 1")
      expect(page).to have_content("This is the description for fruit 1")
      expect(page).to have_content("Fruit")
      expect(page).to have_content("active")
      expect(page).to have_link("edit")
    end
  end
  scenario "Admin clicks on edit button and can edit that Product" do
    product1 = Product.first
    @user_one.store.products << product1
    click_link "View All Products"

    within("tr", text: product1.name) do
      click_link "edit"
    end

    expect(current_path).to eq(admin_products_edit_path(@user_one.store, product1))
    expect(page).to have_content("Edit Product")
    expect(page).to have_content("Name")

    name = find("#product_form_name").value
    expect(name).to eq("Fruit 1")

    description = find("#product_form_description").value
    expect(description).to eq("This is the description for fruit 1")
    expect(page).to have_content("Price")
    price = find("#product_form_price").value
    expect(price).to eq("19.99")
    expect(page).to have_content("Status")
    expect(page).to have_content("Fruit")
    expect(page).to have_content("Active")
    expect(page).to have_button("Edit Product")

    find('input[type="text"][name*="name"]').set("Peach")
    find('input[type="text"][name*="description"]').set("A peach.")
    find('input[type="text"][name*="price"]').set("12.99")
    select "Retired", from: "product[status]"
    click_button "Edit Product"

    expect(current_path).to eq(admin_products_path(@user_one.store))
    within("tr", text: "Peach") do
      expect(page).to have_content("Peach")
      expect(page).to have_content("A peach.")
      expect(page).to have_content("12.99")
      expect(page).to have_content("inactive")
      expect(page).to have_link("edit")
    end
  end
end
