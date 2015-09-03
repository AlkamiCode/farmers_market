require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  describe 'new user mailer' do
    let(:user) { User.create(first_name: 'Bob', email: "bob@example.com") }
    let(:mail) { NotificationsMailer.new_user(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq("Welcome to Farmers Market, Bob!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['welcome@farmersmarket.com'])
    end
  end

  describe 'new store mailer' do
    let(:current_user) { User.create(id: 1, first_name: 'Bill', email: 'bill@example.com') }
    let(:store) { Store.create(farm_name: "Bill's Store", user_id: current_user.id)}
    let(:mail) { NotificationsMailer.new_store(current_user) }

    xit 'renders the subject' do
      expect(mail.subject).to eq("Welcome to Farmers Market, My Shop!")
    end

    xit 'renders the receiver email' do
      expect(mail.to).to eq([current_user.email])
    end
  end

  describe 'user order mailer' do
    let(:user) { User.create(first_name: "Bob", email: "bob@something.com") }
    let(:mail) { NotificationsMailer.user_order(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq("Thank you for your order, Bob!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['welcome@farmersmarket.com'])
    end
  end

  describe 'store order mailer' do
    let(:stores) { [Store.create(farm_name: 'Store 1'), Store.create(farm_name: 'Store 2')]}
    let(:mail) { NotificationsMailer.store_order(stores)}

    xit 'renders the receiver email' do

    end

    xit 'renders the subject' do
      expect(mail.subject).to eq("Cha! Ching! An order has been placed!")
    end

  end
end
