require 'rails_helper'

RSpec.describe Store, type: :model do
  before do
    @user = User.create(first_name: "Mike",
    last_name:  "Dorrance",
    email:      "mike@aol.com",
    password:   "password")

    @user.store = Store.create(farm_name: "Johnson Farm",
    facebook_url: "facebook.com",
    photo_url: "picture",
    twitter_url: "twitter.com",
    instagram_url: "instagram.com",
    description: "this is a nice farm",
    url: "johnson-farm")

    categories = @user.store.categories << Category.create(
    name: "Grain",
    description: "bread and stuff")

    @user.store.categories << Category.create(
    name: "Fruits",
    description: "apples and stuff")

    @user.store.products << Product.create(
    name: "Wonder Bread",
    description: "Yum!",
    image_url: "bread.jpg",
    price: "19.99",
    category_id: categories.first.id)

    @user.store.products << Product.create(
    name: "Other Bread",
    description: "Meh",
    image_url: "image.png",
    price: "19.99",
    category_id: categories.first.id)
  end

  it 'has many categories' do
    expect(@user.store.categories.count).to eq(2)
  end

  it 'has many products' do
    expect(@user.store.products.count).to eq(2)
  end

  it 'belongs to a user' do
    expect(@user.store.user.first_name).to eq("Mike")
  end
end
