require "rails_helper"
require "factory_helper"

feature "user sees a single past order" do
  context "as an authenticated user with one previous order" do
    before do
      @user = User.create(first_name: "Jane",
                         last_name:  "Doe",
                         email:      "jane@doe.com",
                         password:   "password")

      @user.roles << Role.find_or_create_by(name:"registered_user")

      category = Category.create(name: "Fruit",
                                 description: "Fruit description")

      @product_1 = category.products.create(name:        "Fruit1",
                                            description: "Fruit 1 description",
                                            price:       9.99)

      @product_2 = category.products.create(name:        "Fruit2",
                                            description: "Fruit 2 description",
                                            price:       19.99)

      @order = Order.create(user_id: @user.id,
                            status: "ordered",
                            created_at: DateTime.civil(2015, 07, 05, 21, 33, 0),
                            updated_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

      OrderItem.create(order_id: @order.id,
                       product_id: @product_1.id,
                       quantity: 1,
                       unit_price: @product_1.price)

      OrderItem.create(order_id: @order.id,
                       product_id: @product_2.id,
                       quantity: 2,
                       unit_price: @product_2.price)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(@user)
      page.set_rack_session(user_id: @user.id)
    end

    scenario "user is able to see past order details" do
      visit dashboard_path

      within("td.order-details-link") do
        click_link("View Order Details")
      end

      expect(current_path).to eq(order_path(@order))

      expect(page).to have_content("Order ID: # #{@order.id}")
      expect(page).to have_content("Purchase Date/Time: July  5, 2015 at  9:33 PM")

      within("tr", text: "Fruit1") do
        expect(page).to have_content("Fruit1")
        expect(page).to have_content("1") # qty for Fruit1
        expect(page).to have_content("$9.99") # subtotal
        expect(page).to have_xpath("//a[@href=\"#{product_path(@product_1)}\"]")
      end

      within("tr", text: "Fruit2") do
        expect(page).to have_content("Fruit2")
        expect(page).to have_content("2") # qty for Fruit2
        expect(page).to have_content("$39.98") # subtotal
        expect(page).to have_xpath("//a[@href=\"#{product_path(@product_2)}\"]")
      end

      expect(page).to have_content("ordered", count: 2) # status
      expect(page).to have_content("$49.97") # total
    end

    scenario "if order was completed/cancelled, timestamp is displayed" do
      @order.update(status: "cancelled")
      @order.update(updated_at: DateTime.civil(2015, 8, 2, 21, 33, 0))

      visit order_path(@order)
      within(".other-notes") do
        expect(page).to have_content("This order was cancelled on " \
          "August  2, 2015 at 9:33 PM.")
      end
    end
  end
end
