require "rails_helper"
require "factory_helper"

feature "Visitor" do

  before do
    build_products
    build_farms
  end

  context "who is not logged in with an empty cart" do
    scenario "adds one item" do
      item1 = @fruit.products.first

      @store_one.products << item1

      visit product_path(item1)
      within(".caption-full") do
        click_button "Add to Cart"
      end

      expect(current_path).to eq product_path(item1)
      expect(page).to have_content("added to cart")

      within(".caption-full") do
        click_button "Add to Cart"
      end

      expect(page).to have_content("added to cart")

      find("#cart").click

      expect(current_path).to eq(cart_path)

      within(".name") do
        expect(page).to have_content("Fruit 1")
      end

      within(".row", text: "Fruit 1") do
        quantity = find(".quantity").value
        expect(quantity).to eq("2")
      end

      within(".total") do
        expect(page).to have_content("$39.98")
      end
    end

    scenario "adds two items to the cart" do
      item1 = @fruit.products.first
      item2 = @grains.products.last

      @store_one.products << item1
      @store_one.products << item2

      visit product_path(item1)
      within(".caption-full") do
        click_button "Add to Cart"
      end
      within(".caption-full") do
        click_button "Add to Cart"
      end

      expect(page).to have_content("added to cart")

      visit product_path(item2)
      within(".caption-full") do
        click_button "Add to Cart"
      end

      expect(page).to have_content("added to cart")

      find("#cart").click

      expect(current_path).to eq(cart_path)
      within(".row", text: "Fruit 1") do
        expect(page).to have_content("Fruit 1")
        quantity = find(".quantity").value
        expect(quantity).to eq("2")
        expect(page).to have_content("$39.98")
      end
      within(".row", text: "Grain 3") do
        expect(page).to have_content("Grain")
        quantity = find(".quantity").value
        expect(quantity).to eq("1")
        expect(page).to have_content("$39.99")
      end
    end

    scenario "adds two items and updates the quantity of one" do
      item1 = @fruit.products.first
      item2 = @grains.products.last

      @store_one.products << item1
      @store_one.products << item2

      visit product_path(item1)
      within(".caption-full") do
        click_button "Add to Cart"
      end

      visit product_path(item2)
      within(".caption-full") do
        click_button "Add to Cart"
      end

      find("#cart").click

      within(".row", text: "Fruit 1") do
        find(".quantity").set("4")
        click_button("update")
      end

      expect(current_path).to eq(cart_path)

      within(".row", text: "Fruit 1") do
        quantity = find(".quantity").value
        expect(quantity).to eq("4")
        expect(page).to have_content("$79.96")
      end

      within(".total") do
        expect(page).to have_content("$119.95")
      end
    end

    scenario "adds an item twice and then decreases the quantity to one" do
      item = @fruit.products.first

      @store_one.products << item
      visit product_path(item)
      within(".caption-full") do
        click_button "Add to Cart"
      end
      within(".caption-full") do
        click_button "Add to Cart"
      end

      find("#cart").click
      within(".row", text: "Fruit 1") do
        quantity = find(".quantity").value
        expect(quantity).to eq("2")
        expect(page).to have_content("$39.98")
      end

      within(".total") do
        expect(page).to have_content("$39.98")
      end

      within(".row", text: "Fruit 1") do
        find(".quantity").set("1")
        click_button("update")
      end

      expect(current_path).to eq(cart_path)

      within(".row", text: item.name) do
        quantity = find(".quantity").value
        expect(quantity).to eq("1")
        within(".sub-total") do
          expect(page).to have_content("$19.99")
        end
      end

      within(".total") do
        expect(page).to have_content("$19.99")
      end
    end

    scenario "adds an item and attempts to decrease the quantity negative or zero" do
      item = @fruit.products.first

      @store_one.products << item

      visit product_path(item)
      within(".caption-full") do
        click_button "Add to Cart"
      end

      find("#cart").click

      within(".row", text: "Fruit 1") do
        find(".quantity").set("0")
        click_button("update")
      end

      expect(current_path).to eq(cart_path)
      expect(page).to have_content("Cannot set quantity below one.")

      within(".row", text: "Fruit 1") do
        quantity = find(".quantity").value
        expect(quantity).to eq("1")
        within(".sub-total") do
          expect(page).to have_content("$19.99")
        end
      end

      within(".row", text: "Fruit 1") do
        find(".quantity").set("-5")
        click_button("update")
      end

      expect(current_path).to eq(cart_path)
      expect(page).to have_content("Cannot set quantity below one.")

      within(".row", text: "Fruit 1") do
        quantity = find(".quantity").value
        expect(quantity).to eq("1")
        within(".sub-total") do
          expect(page).to have_content("$19.99")
        end
      end
    end

    scenario "adds an item and then clicks the remove link" do
      item = @fruit.products.first

      @store_one.products << item

      visit product_path(item)
      within(".caption-full") do
        click_button "Add to Cart"
      end

      find("#cart").click
      within(".row", text: "Fruit 1") do
        quantity = find(".quantity").value
        expect(quantity).to eq("1")
        expect(page).to have_content("$19.99")
      end

      within(".total") do
        expect(page).to have_content("$19.99")
      end

      within(".row", text: "Fruit 1") do
        click_link("remove")
      end

      expect(current_path).to eq(cart_path)

      within(".flash") do
        expect(page).to have_content("Successfully removed Fruit 1 " \
          "from your cart")
        expect(page).to have_link("Fruit 1")
        expect(page).to have_xpath("//a[@href=\"/products/#{item.id}\"]")
      end

      expect(page).not_to have_content(item.description)

      within(".total") do
        expect(page).not_to have_content("$19.99")
        expect(page).to have_content("$0")
      end
    end
  end
end
