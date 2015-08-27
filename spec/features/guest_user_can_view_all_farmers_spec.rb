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

  xscenario "Guest User clicks products page and sees the products for a given farmer" do
    click_link('Farmers')
    expcect(page).to have_button('Products')

    click_link('Products')
    expect(page).to have_content('Product info')
    #Write Product Info tests once links are built
  end

end