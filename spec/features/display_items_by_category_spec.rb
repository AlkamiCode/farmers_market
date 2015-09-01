require "rails_helper"
require "factory_helper"

feature "a visitor" do
  before do
    build_products
    build_farms
  end

  context "visits /categories/fruit" do
    scenario "and sees all fruit" do
      visit root_path
      click_link("Fruits")

      expect(current_path).to eq(category_path(@fruit.slug))

      within("h1") do
        expect(page).to have_content("Fruit")
      end

      within("#category-description") do
        expect(page).to have_content("Fruits are good for you!")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Fruit 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/fruit/bananas.jpg\"]")
    end
  end

  context "visits /categories/baked_goods" do
    scenario "and sees all baked good products" do
      visit root_path
      click_link("Baked Goods")

      expect(current_path).to eq(category_path(@baked_goods.slug))

      within("h1") do
        expect(page).to have_content("Baked Goods")
      end

      within("#category-description") do
        expect(page).to have_content("Yummy bread.")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Baked Good 3")
      expect(page).to have_content("29.99")
      expect(page).to have_xpath("//img[@src=\"/assets/baked_goods/pie.jpg\"]")
    end
  end

  context "visits /categories/canned_goods" do
    scenario "and sees all canned_goods" do
      visit root_path
      click_link("Canned Goods")

      expect(current_path).to eq(category_path(@canned_goods.slug))

      within("h1") do
        expect(page).to have_content("Canned Goods")
      end

      within("#category-description") do
        expect(page).to have_content("Glass food.")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Canned Good 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/canned_goods/jelly.jpg\"]")
    end
  end

  context "visits /categories/crafts" do
    scenario "and sees all crafts" do
      visit root_path
      click_link("Crafts")

      expect(current_path).to eq(category_path(@crafts.slug))

      within("h1") do
        expect(page).to have_content("Crafts")
      end

      within("#category-description") do
        expect(page).to have_content("DIY goodness.")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Craft 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/crafts/bus.jpg\"]")
    end
  end

  context "visits /categories/drinks" do
    scenario "and sees all drinks" do
      visit root_path
      click_link("Drinks")

      expect(current_path).to eq(category_path(@drinks.slug))

      within("h1") do
        expect(page).to have_content("Drinks")
      end

      within("#category-description") do
        expect(page).to have_content("Liquid goodness.")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Drink 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/drinks/soda.jpg\"]")
    end
  end

  context "visits /categories/flowers" do
    scenario "and sees all flowers" do
      visit root_path
      click_link("Flowers")

      expect(current_path).to eq(category_path(@flowers.slug))

      within("h1") do
        expect(page).to have_content("Flowers")
      end

      within("#category-description") do
        expect(page).to have_content("Nature's beauty.")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Flower 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/flowers/vase.jpg\"]")
    end
  end

  context "visits /categories/grains" do
    scenario "and sees all grains" do
      visit root_path
      click_link("Grains")

      expect(current_path).to eq(category_path(@grains.slug))

      within("h1") do
        expect(page).to have_content("Grains")
      end

      within("#category-description") do
        expect(page).to have_content("Grains. Grains. Grains.")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Grain 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/grains/wheat.jpg\"]")
    end
  end

  context "visits /categories/herbs" do
    scenario "and sees all herbs" do
      visit root_path
      click_link("Herbs")

      expect(current_path).to eq(category_path(@herbs.slug))

      within("h1") do
        expect(page).to have_content("Herbs")
      end

      within("#category-description") do
        expect(page).to have_content("Herbs, herbs, herbs goodness.")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Herb 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/herbs/fresh-herbs.jpg\"]")
    end
  end

  context "visits /categories/seeds" do
    scenario "and sees all seeds" do
      visit root_path
      click_link("Seeds")

      expect(current_path).to eq(category_path(@seeds.slug))

      within("h1") do
        expect(page).to have_content("Seeds")
      end

      within("#category-description") do
        expect(page).to have_content("Grown from seeds.")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Seed 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/seeds/seeds.jpg\"]")
    end
  end

  context "visits /categories/vegetables" do
    scenario "and sees all vegetables" do
      visit root_path
      click_link("Vegetables")

      expect(current_path).to eq(category_path(@vegetables.slug))

      within("h1") do
        expect(page).to have_content("Vegetables")
      end

      within("#category-description") do
        expect(page).to have_content("Yummy Veggies")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Vegetable 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/vegetables/tomatoes.jpg\"]")
    end
  end
end
