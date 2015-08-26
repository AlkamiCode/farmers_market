require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'has many users' do
    role = Role.create(name: 'admin')
    expect(role.users).to eq([])
  end
end
