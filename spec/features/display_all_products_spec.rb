require "rails_helper"
require "factory_helper"

feature "a visitor" do
  context "visits /products" do
    before do
      build_products
    end

    scenario "and sees all products" do
      visit products_path

      expect(page).to have_selector(".thumbnail", count: 30)
      expect(page).to have_content("Fruit 3")
      expect(page).to have_content("49.99")
    end
  end
end
