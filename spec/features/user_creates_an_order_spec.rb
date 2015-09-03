require "rails_helper"
require "factory_helper"

feature "Existing user places an order" do
  context "while logged and with a cart with products" do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    before do

      @user = User.create(first_name: "Jane",
      last_name:  "Doe",
      email:      "jane@doe.com",
      password:   "password")

      @user.roles << Role.find_or_create_by(name:"registered_user")

      category = Category.create(name: "Plants",
      description: "Plants category description",
      slug: "plants")

      product_1 = category.products.create(name:        "Fruit1",
      description: "Fruit 1 description",
      price:       9.99)

      product_2 = category.products.create(name:        "Fruit2",
      description: "Fruit 2 description",
      price:       19.99)

      user_cart = Cart.new(nil)
      user_cart.add_item(product_1)
      user_cart.add_item(product_2)

      allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@user)
      page.set_rack_session(user_id: @user.id)

      allow_any_instance_of(ApplicationController)
      .to receive(:cart).and_return(user_cart)

      @customer = Stripe::Customer.create({
        email: 'jane@doe.com',
        card: stripe_helper.generate_card_token
        })
      end

      scenario "user will use stripe when checking out" do
        expect(@customer.email).to eq("jane@doe.com")
      end
    end

    context "as a visitor, before logging in" do
      scenario "user is is not able to checkout" do
        visit cart_path

        expect(page).to_not have_link("Checkout")
      end
    end

    context "while logged in with an empty cart" do
      scenario "user is not able to checkout" do
        @user = User.create(first_name: "Jane",
        last_name:  "Doe",
        email:      "jane@doe.com",
        password:   "password")

        @user.roles << Role.find_or_create_by(name:"registered_user")

        allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(@user)
        page.set_rack_session(user_id: @user.id)

        visit cart_path

        expect(page).to_not have_link("Checkout")
      end
    end
  end
