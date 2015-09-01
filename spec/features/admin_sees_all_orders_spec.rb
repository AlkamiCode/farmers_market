require "rails_helper"

feature "admin can see all orders" do
  before do
    @admin = User.create(first_name: "Jane",
    last_name:  "Doe",
    email:      "jane@gmail.com",
    password:   "password")

    @admin.roles << Role.create(name: "store_admin")

    @admin.store = Store.create(farm_name: "Carmer's Ranch", facebook_url: "https://www.facebook.com/turingschool",
    instagram_url: "https://instagram.com/", twitter_url: "twitter.com",
    description: "Here at the Carmer Ranch, we have lots of food...and chickens.")

    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(@admin)

    user = User.create(first_name: "Jane",
    last_name:  "Doe",
    email:      "jane@gmail.com",
    password:   "password")

    category = Category.create(name: "Plants",
    description: "Plants category description",
    slug: "plants")

    product = category.products.create(name:        "Plant1",
    description: "Plant 1 description",
    price:       9.99)

    @admin.store.products << product

    @order_1 = Order.create(user_id: user.id,
    status: "ordered",
    created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

    @order_1.order_items.create(product_id: product.id,
    quantity: 1,
    unit_price: product.price)

    @order_2 = Order.create(user_id: user.id,
    status: "paid",
    created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

    @order_2.order_items.create(product_id: product.id,
    quantity: 1,
    unit_price: product.price)

    @order_3 = Order.create(user_id: user.id,
    status: "cancelled",
    created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

    @order_3.order_items.create(product_id: product.id,
    quantity: 1,
    unit_price: product.price)

    @order_4 = Order.create(user_id: user.id,
    status: "completed",
    created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

    @order_4.order_items.create(product_id: product.id,
    quantity: 1,
    unit_price: product.price)

    @order_5 = Order.create(user_id: user.id,
    status: "completed",
    created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))


    @order_5.order_items.create(product_id: product.id,
    quantity: 1,
    unit_price: product.price)
  end

  scenario "an admin can view all orders" do
    visit admin_dashboard_path(@admin.store)

    expect(current_path).to eq(admin_dashboard_path(@admin.store))

    click_link("View All Orders")

    expect(current_path).to eq(admin_orders_path(@admin.store))

  end

  scenario "and a link for each individual order" do
    visit admin_orders_path(@admin.store)

    expect(current_path).to eq(admin_orders_path(@admin.store))

    expect(page).to have_content("$9.99")
    expect(page).to have_content("July  5, 2015 at  9:33 PM")
  end
end
