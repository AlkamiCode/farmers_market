require "rails_helper"
require "factory_helper"

feature "a visitor" do
  context "visits /products/:id" do
      before do
        @fruit = Category.create(
          name: "Fruit",
          description: "Fruits are good for you!")

        @fruit.products.create(
          name: "Fruit 1",
          description: "This is the description for fruit 1",
          price: 19.99,
          image_url: "fruit/bananas.jpg")

        @fruit.products.create(
          name: "Fruit 2",
          description: "This is the description for fruit 2",
          price: 29.99,
          image_url: "fruit/blueberries.jpg")

        @fruit.products.create(
          name: "Fruit 3",
          description: "This is the description for fruit 3",
          price: 39.99,
          image_url: "fruit/rasberries.jpg")
          
        build_farms
      end

    scenario "and sees product details" do
      product = @fruit.products.first
      @store_one.products << product
      visit product_path(product.id)
      expect(page).to have_content("Fruit 1")
      expect(page).to have_content("This is the description for fruit 1")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@alt='Fruit 1 image']")

      within(".caption-full") do
        expect(page).to have_xpath(
          "//input[@value=\"Add to Cart\"]")
      end
    end

    scenario "and sees featured products" do
      product1 = @fruit.products.first
      product2 = @fruit.products.second
      product3 = @fruit.products.last
      @store_one.products << product1
      @store_one.products << product2
      @store_one.products << product3

      visit product_path(product1)

      within("#product-carousel") do
        expect(page).to have_content("Fruit 1")
        expect(page).to have_content("19.99")
        expect(page).to have_xpath("//img[@alt='Fruit 1 image']")
        expect(page).to have_content("Fruit 2")
        expect(page).to have_content("29.99")
        expect(page).to have_xpath("//img[@alt='Fruit 2 image']")
        expect(page).to have_content("Fruit 3")
        expect(page).to have_content("39.99")
        expect(page).to have_xpath("//img[@alt='Fruit 3 image']")
      end
    end
  end
end
