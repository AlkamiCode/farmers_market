require "rails_helper"
require "factory_helper"

feature "admin user" do
  before do
    build_products
    build_farms
    allow_any_instance_of(ApplicationController).to receive(
    :current_user).and_return(@user_one)

    @user_one.store.products << Product.first

    @user_one.orders << Order.create()
    oi = OrderItem.create(quantity: 3, product_id: Product.first.id)
    @user_one.orders.first.order_items <<  oi

    visit admin_orders_path(@user_one.store)

  end

  scenario "can view all orders" do
    order = @user_one.orders.first
    expect(current_path).to eq(admin_orders_path(@user_one.store))
    expect(page).to have_content("#{order.id}")

    expect(page).to have_content("Ordered")

    expect(page).to have_content("$59.97")
  end


  scenario "can view individual orders" do
    order = @user_one.orders.first
    visit admin_order_path(order)
    expect(current_path).to eq(admin_order_path(order))

    expect(page).to have_content("Order ID: # #{order.id}")

    expect(page).to have_content("User: Ama Luna")

    expect(page).to have_content("$59.97")
  end
end
