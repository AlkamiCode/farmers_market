require "rails_helper"
require Rails.root.join 'lib/faker/products'
require 'faker'

feature "registered user can view individual shop" do
  before do
    user = User.create(first_name: "Jane",
                       last_name:  "Doe",
                       email:      "jane@doe.com",
                       password:   "password",
                       )
    user.roles << Role.create(name: "registered_user")

    store_owner = User.create(email: "andrew@turing.io", password: "password", first_name: "Andrew",
    last_name: "Carmer")
    store_owner.roles << Role.create(name: "store_admin")
    store_owner.store = Store.create(farm_name: "Carmer's Ranch", facebook_url: "https://www.facebook.com/turingschool",
    instagram_url: "https://instagram.com/", twitter_url: "twitter.com",
    description: "Here at the Carmer Ranch, we have lots of food...and chickens.")
    herbs = Category.create(
    name: "Herbs",
    description: "No, not that kind of herb."
    )

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

  it 'can view the farmers page' do
    visit "/carmer-s-ranch"

    expect(page).to have_content("Carmer's Ranch")
    expect(page).to have_content("Here at the Carmer Ranch, we have lots of food...and chickens.")
  end
end
