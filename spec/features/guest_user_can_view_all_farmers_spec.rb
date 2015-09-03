require 'rails_helper'
require 'factory_helper'

feature "Guest User can view all farmers" do
  before do
    build_farms
    build_products

    visit root_path
  end

  scenario "Guest User visits Farmers page and sees all farmers" do
    click_link('Farmers')
    expect(page).to have_content("Your Farm Families")
    expect(page).to have_content("Amaluna Farms")
    expect(page).to have_content("French Farm Fresh Food served by acrobats in tights.  How much more French can you get?")
    expect(page).to have_link('Products')
    expect(page).to have_button('Profile')
  end

  scenario "Guest User clicks products page and sees the products for a given farmer" do
    click_link('Farmers')
    expect(page).to have_link('Products')

    within(".farmer-buttons") do
      click_link('Products')
    end

    expect(current_path).to eq("/amaluna-farms")
    expect(page).to have_content('Amaluna Farms')
    expect(page).to have_content('French Farm Fresh Food served by acrobats in tights.  How much more French can you get?')
  end
end
