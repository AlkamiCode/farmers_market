require "rails_helper"
require "factory_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  before do
    @user = User.create(first_name: "Jane",
                        last_name:  "Doe",
                        email:      "jane@doe.com",
                        password:   "password")

    @user.roles << Role.find_or_create_by(name:"registered_user")

    build_farms

    allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
                .and_return(@user)

    allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
                .and_return(@user)

    allow_any_instance_of(ApplicationController)
        .to receive(:cart).and_return(@user_cart)
  end

  describe 'new user mailer' do
    let(:user) { @user }
    let(:mail) { NotificationsMailer.new_user(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq("Welcome to Farmers Market, Jane!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['welcome@farmersmarket.com'])
    end
  end

  describe 'new store mailer' do
    let(:current_user) { @user_one }
    let(:store) { @store_one }
    let(:mail) { NotificationsMailer.new_store(current_user) }

    it 'renders the subject' do
      expect(mail.subject).to eq("Welcome to Farmers Market, Amaluna Farms!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([current_user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['welcome@farmersmarket.com'])
    end
  end

  describe 'user order mailer' do
    let(:user) { @user }
    let(:mail) { NotificationsMailer.user_order(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq("Thank you for your order, Jane!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['welcome@farmersmarket.com'])
    end
  end

  describe 'store order mailer' do
    let(:stores) { @store_one }


    let(:cart) { @fruit = Category.create(name: "Plants",
                                          description: "Plants category description",
                                          slug: "plants")

                  [   @fruit.products.create(
                      name: "Fruit 1",
                      description: "This is the description for fruit 1",
                      price: 19.99,
                      image_url: "fruit/bananas.jpg",
                      store_id: @store_one.id),

                      @fruit.products.create(
                      name: "Fruit 2",
                      description: "This is the description for fruit 1",
                      price: 19.99,
                      image_url: "fruit/bananas.jpg",
                      store_id: @store_one.id)
    ]}

    let(:current_user) { @user_one }
    let(:mail) { NotificationsMailer.store_order(cart)}

    it 'renders the subject' do
      expect(mail.subject).to eq("Cha! Ching! An order has been placed!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([current_user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['welcome@farmersmarket.com'])
    end

  end
end
