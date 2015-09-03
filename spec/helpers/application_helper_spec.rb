require "rails_helper"

describe ApplicationHelper do 

  it 'returns true for store admin' do
    @admin = User.create(first_name: "Mike",
    last_name: "Dorrance",
    email: "mike@mike.com",
    password: "12345678",)
    @admin.roles << Role.find_or_create_by(name: "store_admin")

    allow_any_instance_of(ApplicationHelper)
    .to receive(:current_user).and_return(@admin)

    expect(store_admin?).to eq(true)

  end

  it 'returns true for platform admin' do
    @admin = User.create(first_name: "Mike",
    last_name: "Dorrance",
    email: "mike@mike.com",
    password: "12345678",)
    @admin.roles << Role.find_or_create_by(name: "platform_admin")

    allow_any_instance_of(ApplicationHelper)
    .to receive(:current_user).and_return(@admin)

    expect(platform_admin?).to eq(true)

  end

  it 'returns true for registered user' do
    user = User.create(first_name: "Mike",
    last_name: "Dorrance",
    email: "mike@mike.com",
    password: "12345678",)
    user.roles << Role.find_or_create_by(name: "registered_user")

    allow_any_instance_of(ApplicationHelper)
    .to receive(:current_user).and_return(user)

    expect(registered_user?).to eq(true)
  end

  it 'returns false for wrong permissions' do
    @admin = User.create(first_name: "Mike",
    last_name: "Dorrance",
    email: "mike@mike.com",
    password: "12345678",)
    @admin.roles << Role.find_or_create_by(name: "platform_admin")

    allow_any_instance_of(ApplicationHelper)
    .to receive(:current_user).and_return(@admin)

    expect(registered_user?).to eq(false)
  end

end
