require "rails_helper"

feature "a user" do
  before do
    build_products
    build_farms

    @fruit4 = @fruit.products.create(
                   name:        "Fruit 4",
                   description: "This is the description for fruit 4",
                   price:       59.99,
                   image_url:   "fruit/rasberries.jpg",
                   status:      "inactive")
    item1 = @fruit.products.first
    item2 = @fruit.products.second
    item3 = @fruit4

    @store_one.products << item1
    @store_one.products << item2
    @store_one.products << item3
  end

  scenario "can see all active products" do
    visit products_path

    within(".thumbnail", text: "Fruit 1") do
      expect(page).to have_content("This is the description for fruit 1")
      expect(page).to have_content("$19.99")
    end
    within(".thumbnail", text: "Fruit 2") do
      expect(page).to have_content("This is the description for fruit 2")
      expect(page).to have_content("$29.99")
    end
  end

  scenario "cannot see retired products in the products index" do
    visit products_path

    expect(page).not_to have_content("This is the description for fruit 4")
    expect(page).not_to have_content("$59.99")
  end

  scenario "can access a retired product but cannot add it to the cart" do
    visit product_path(@fruit4)

    expect(current_path).to eq product_path(@fruit4)
    expect(page).to have_css("input[value*='Retired']")
  end
end
