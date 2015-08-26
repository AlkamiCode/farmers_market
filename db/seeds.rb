require Rails.root.join 'lib/faker/products'
require 'faker'

class Seed
  def self.start
    seed = Seed.new
    seed.generate_baked_products
    seed.generate_canned_products
    seed.generate_craft_products
    seed.generate_drink_products
    seed.generate_flower_products
    seed.generate_grain_products
    seed.generate_herb_products
    seed.generate_seed_products
    seed.generate_fruit_products
    seed.generate_vegetable_products
    seed.generate_users
    seed.generate_orders
  end
  # Products

  def generate_baked_products
    baked = Category.create(
    name: "Baked Goods",
    description: "Baked goods just like your mom used to make!"
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.food, description: Faker::Products.description,
      image_url: Faker::Products.image, price: Faker::Commerce.price.to_d,
      category_id: baked.id
      )
    end
  end

  def generate_canned_products
    canned = Category.create(
    name: "Canned Goods",
    description: "All of your fresh food stored for later!"
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.canned_food, description: Faker::Products.canned_description,
      image_url: Faker::Products.canned_image, price: Faker::Commerce.price.to_d,
      category_id: canned.id
      )
    end
  end

  def generate_craft_products
    crafts = Category.create(
    name: "Crafts",
    description: "Want a new DIY project? We've got you covered!"
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.crafts_supplies, description: Faker::Products.crafts_description,
      image_url: Faker::Products.crafts_image, price: Faker::Commerce.price.to_d,
      category_id: crafts.id
      )
    end
  end

  def generate_flower_products
    flowers = Category.create(
    name: "Flowers",
    description: "Wife mad at you? We've got you covered!"
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.flowers_flower, description: Faker::Products.flowers_description,
      image_url: Faker::Products.flowers_image, price: Faker::Commerce.price.to_d,
      category_id: flowers.id
      )
    end
  end

  def generate_fruit_products
    fruit = Category.create(
    name: "Fruit",
    description: "Fruit fresh from the orchard!"
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.fruits_fruit, description: Faker::Products.fruits_description,
      image_url: Faker::Products.fruits_image, price: Faker::Commerce.price.to_d,
      category_id: fruit.id
      )
    end
  end

  def generate_grain_products
    grains = Category.create(
    name: "Grains",
    description: "Perfect for making your home made bread."
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.grains_grain, description: Faker::Products.grains_description,
      image_url: Faker::Products.grains_image, price: Faker::Commerce.price.to_d,
      category_id: grains.id
      )
    end
  end

  def generate_herb_products
    herbs = Category.create(
    name: "Herbs",
    description: "No, not that kind of herb."
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.herbs_herb, description: Faker::Products.herbs_description,
      image_url: Faker::Products.herbs_image, price: Faker::Commerce.price.to_d,
      category_id: herbs.id
      )
    end
  end

  def generate_seed_products
    seeds = Category.create(
    name: "Seeds",
    description: "Perfect for that garden you've been wanting to grow!"
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.seeds_seed, description: Faker::Products.seeds_description,
      image_url: Faker::Products.seeds_image, price: Faker::Commerce.price.to_d,
      category_id: seeds.id
      )
    end
  end

  def generate_vegetable_products
    vegetables = Category.create(
    name: "Vegetables",
    description: "Fall is right around the corner, get some freshly harvested vegetables for your supper!"
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.vegetables_vegetable, description: Faker::Products.vegetables_description,
      image_url: Faker::Products.vegetables_image, price: Faker::Commerce.price.to_d,
      category_id: vegetables.id
      )
    end
  end

  def generate_drink_products
    drinks = Category.create(
    name: "Drinks",
    description: "Delicious and refreshing."
    )
    10.times do |i|
      Product.create!(
      name: Faker::Products.drinks_drink, description: Faker::Products.drinks_description,
      image_url: Faker::Products.drinks_image, price: Faker::Commerce.price.to_d,
      category_id: drinks.id
      )
    end
  end


  def generate_users
    registered = User.create(email: "josh@turing.io", password: "password", first_name: "Josh",
    last_name: "Meija")
    store = User.create(email: "andrew@turing.io", password: "password", first_name: "Andrew",
    last_name: "Carmer")
    platform = User.create(email: "jorge@turing.io", password: "password", first_name: "Jorge",
    last_name: "Telez")
    store.roles << Role.create(name: "store_admin")
    registered.roles << Role.create(name: "registered_user")
    platform.roles << Role.create(name: "platform_admin")
    50.times do |i|
      user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      password: "password",
      email: Faker::Internet.email
      )
      puts "User #{i}: #{user.first_name} - #{user.email} created!"
    end
  end

  def generate_orders
    100.times do |i|
      user  = User.find(Random.new.rand(1..50))
      order = Order.create!(user_id: user.id, status: 1)
      add_products(order)
      puts "Order #{i}: Order for #{user.first_name} created!"
    end
  end

  private

  def add_products(order)
    10.times do |i|
      product = Product.find(Random.new.rand(1..99))
      OrderItem.create(order_id: order.id, product_id: product.id, quantity: 3)
      puts "#{i}: Added item #{product.name} to order #{order.id}."
    end
  end
end
Seed.start
