require Rails.root.join 'lib/faker/products'
require 'faker'

class Seed
  def self.start
    seed = Seed.new
    seed.generate_stores
    seed.generate_users
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
    seed.generate_orders
    seed.assign_left_over_products
  end
  # Products

  def generate_baked_products
    baked = Category.create(
    name: "Baked Goods",
    description: "Baked goods just like your mom used to make!"
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.food, description: Faker::Products.description,
      image_url: Faker::Products.image, price: Faker::Commerce.price.to_d + 1,
      category_id: baked.id
      )
      puts "create product number #{i}"
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end

  def generate_canned_products
    canned = Category.create(
    name: "Canned Goods",
    description: "All of your fresh food stored for later!"
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.canned_food, description: Faker::Products.canned_description,
      image_url: Faker::Products.canned_image, price: Faker::Commerce.price.to_d + 1,
      category_id: canned.id
      )
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end

  def generate_craft_products
    crafts = Category.create(
    name: "Crafts",
    description: "Want a new DIY project? We've got you covered!"
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.crafts_supplies, description: Faker::Products.crafts_description,
      image_url: Faker::Products.crafts_image, price: Faker::Commerce.price.to_d + 1,
      category_id: crafts.id
      )
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end

  def generate_flower_products
    flowers = Category.create(
    name: "Flowers",
    description: "Wife mad at you? We've got you covered!"
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.flowers_flower, description: Faker::Products.flowers_description,
      image_url: Faker::Products.flowers_image, price: Faker::Commerce.price.to_d + 1,
      category_id: flowers.id
      )
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end

  def generate_fruit_products
    fruit = Category.create(
    name: "Fruit",
    description: "Fruit fresh from the orchard!"
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.fruits_fruit, description: Faker::Products.fruits_description,
      image_url: Faker::Products.fruits_image, price: Faker::Commerce.price.to_d + 1,
      category_id: fruit.id
      )
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end

  def generate_grain_products
    grains = Category.create(
    name: "Grains",
    description: "Perfect for making your home made bread."
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.grains_grain, description: Faker::Products.grains_description,
      image_url: Faker::Products.grains_image, price: Faker::Commerce.price.to_d + 1,
      category_id: grains.id
      )
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end

  def generate_herb_products
    herbs = Category.create(
    name: "Herbs",
    description: "No, not that kind of herb."
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.herbs_herb, description: Faker::Products.herbs_description,
      image_url: Faker::Products.herbs_image, price: Faker::Commerce.price.to_d + 1,
      category_id: herbs.id
      )
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end

  def generate_seed_products
    seeds = Category.create(
    name: "Seeds",
    description: "Perfect for that garden you've been wanting to grow!"
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.seeds_seed, description: Faker::Products.seeds_description,
      image_url: Faker::Products.seeds_image, price: Faker::Commerce.price.to_d + 1,
      category_id: seeds.id
      )
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end

  def generate_vegetable_products
    vegetables = Category.create(
    name: "Vegetables",
    description: "Fall is right around the corner, get some freshly harvested vegetables for your supper!"
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.vegetables_vegetable, description: Faker::Products.vegetables_description,
      image_url: Faker::Products.vegetables_image, price: Faker::Commerce.price.to_d + 1,
      category_id: vegetables.id
      )
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end

  def generate_drink_products
    drinks = Category.create(
    name: "Drinks",
    description: "Delicious and refreshing."
    )
    50.times do |i|
      Product.create!(
      name: Faker::Products.drinks_drink, description: Faker::Products.drinks_description,
      image_url: Faker::Products.drinks_image, price: Faker::Commerce.price.to_d + 1,
      category_id: drinks.id
      )
    end
    stores = []
    10.times do |i|
      stores <<  Store.find(Random.new.rand(1..21))
    end
    stores.each do |store|
      added = 0
      puts "added a product to #{Product.last.category}"
      products = Product.last(50)
      while added < 3
        product = products[Random.new.rand(0..49)]
        if !product.store_id
          store.products << product
          store.categories << product.category
          added += 1
          puts "added a product to #{store.farm_name}"
        end
      end
    end
  end


  def generate_users
    registered = User.create(email: "josh@turing.io", password: "password", first_name: "Josh",
    last_name: "Meija")
    platform = User.create(email: "jorge@turing.io", password: "password", first_name: "Jorge",
    last_name: "Telez")
    registered.roles << Role.create(name: "registered_user")
    platform.roles << Role.create(name: "platform_admin")
    100.times do |i|
      user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      password: "password",
      email: Faker::Internet.email
      )
      user.roles << Role.find_by(name: "registered_user")
      puts "User #{i}: #{user.first_name} - #{user.email} created!"
    end
  end

  def generate_orders
    User.all.each do |user|
      if user.roles.exists?(name: "registered_user")
        10.times do |i|
          order = Order.create!(user_id: user.id, status: 1)
          add_products(order)
          puts "Order #{i}: Order for #{user.first_name} created!"
        end
      end
    end
  end

  def generate_stores
    Role.create(name: "store_admin")
    
    20.times do |i|
      user = User.create(email: "farmer#{i}@turing.io", password: "password", first_name: "Farmer#{i}",
      last_name: "Johnson")
      user.roles << Role.find_by(name: "store_admin")
      user.store = Store.create(farm_name: "#{user.first_name}'s farm'", facebook_url: "https://www.facebook.com/turingschool",
      instagram_url: "https://instagram.com/", twitter_url: "twitter.com",
      description: "We have good food, you should eat it.", photo_url: random_picture)
    end
    store_owner = User.create(email: "andrew@turing.io", password: "password", first_name: "Andrew",
    last_name: "Carmer")
    store_owner.roles << Role.find_by(name: "store_admin")
    store_owner.store = Store.create(farm_name: "Carmer's Ranch", facebook_url: "https://www.facebook.com/turingschool",
    instagram_url: "https://instagram.com/", twitter_url: "twitter.com",
    description: "Here at the Carmer Ranch, we have lots of food...and chickens.", photo_url: random_picture)
  end


  def assign_left_over_products
    Product.all.each do |product|
      Store.find(Random.new.rand(1..21)).products << product if !product.store_id
    end
  end

  private

  def random_picture
    ["farmers/amish-hay.jpg", "farmers/dairy_farm_family.jpg", "farmers/fall_farm_family.jpg",
      "farmers/familyfarms_hay.jpg", "farmers/female_farmer.jpg", "farmers/hispanic_farmer.jpg",
      "farmers/large_family.jpg", "farmers/multi-generation.jpg", "farmers/orchard.jpg",
      "farmers/pumkin_farmer.jpg", "farmers/spreading_ladybugs.jpg", "farmers/tractor_family.jpg",
      "farmers/young_farm_family.jpg", "farmers/young_hay_field.jpg"].sample
    end

    def add_products(order)
      10.times do |i|
        product = Product.find(Random.new.rand(1..99))
        OrderItem.create(order_id: order.id, product_id: product.id, quantity: 3)
        puts "#{i}: Added item #{product.name} to order #{order.id}."
      end
    end
  end
  Seed.start
