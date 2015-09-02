require "rails_helper"
require "factory_helper"

feature "a visitor" do
  before do
    build_products
    build_farms
  end

  context "visits /categories/baked-goods" do
    scenario "and clicks subnav to see all fruit" do
      visit root_path
      click_link("Baked Goods")

      expect(current_path).to eq(category_path(@baked_goods.slug))

      within(".subnav") do
        click_link("Fruits")
      end
      expect(current_path).to eq(category_path(@fruit.slug))

      within("#category-description") do
        expect(page).to have_content("Fruits are good for you!")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Fruit 3")
      expect(page).to have_content("19.99")
    end
  end

  context "visits /categories/fruits" do
    scenario "and clicks subnav to see all baked good products" do
      visit root_path
      click_link("Fruits")

      expect(current_path).to eq(category_path(@fruit.slug))

      within(".subnav") do
        click_link("Baked Goods")
      end

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
    end
  end

  context "visits /categories/crafts" do
    scenario "and clicks on subnav to see all canned_goods" do
      visit root_path
      click_link("Crafts")
      expect(current_path).to eq(category_path(@crafts.slug))

      within(".subnav") do
        click_link("Canned Goods")
      end

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
    end
  end

  context "visits /categories/canned-goods" do
    scenario "and clicks on subnav to see all crafts" do
      visit root_path
      click_link("Canned Goods")

      expect(current_path).to eq(category_path(@canned_goods.slug))

      within(".subnav") do
        click_link("Crafts")
      end

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
    end
  end

  context "visits /categories/flowers" do
    scenario "and clicks on subnav to see all drinks" do
      visit root_path
      click_link("Flowers")

      expect(current_path).to eq(category_path(@flowers.slug))

      within(".subnav") do
        click_link("Drinks")
      end

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
    end
  end

  context "visits /categories/drinks" do
    scenario "and clicks on subnav to see all flowers" do
      visit root_path
      click_link("Drinks")

      expect(current_path).to eq(category_path(@drinks.slug))

      within(".subnav") do
        click_link("Flowers")
      end

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
    end
  end

  context "visits /categories/herbs" do
    scenario "clicks on subnav to see all grains" do
      visit root_path
      click_link("Herbs")

      expect(current_path).to eq(category_path(@herbs.slug))

      within(".subnav") do
        click_link("Grains")
      end

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
    end
  end

  context "visits /categories/grains" do
    scenario "clicks on subnav to see all herbs" do
      visit root_path
      click_link("Grains")

      expect(current_path).to eq(category_path(@grains.slug))

      within(".subnav") do
        click_link("Herbs")
      end

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
    end
  end

  context "visits /categories/vegetables" do
    scenario "clicks on subnav to see all seeds" do
      visit root_path
      click_link("Vegetables")

      expect(current_path).to eq(category_path(@vegetables.slug))

      within(".subnav") do
        click_link("Seeds")
      end

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
    end
  end

  context "visits /categories/seeds" do
    scenario "clicks on subnav to see all vegetables" do
      visit root_path
      click_link("Seeds")

      expect(current_path).to eq(category_path(@seeds.slug))

      within(".subnav") do
        click_link("Vegetables")
      end

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
    end
  end
end
