require 'rails_helper'

RSpec.describe User, type: :model do
  it "allows us to set user attributes" do
    user = User.create(id: 1, first_name: "Bob", last_name: "Bacon",
                       username: "bb", email: "bb@berkeley.edu",
                       password: "pls", password_confirmation: "pls")

    expect(user.username).to eq("bb")
    expect(user.id).to eq(1)
    expect(user.first_name).to eq("Bob")
    expect(user.last_name).to eq("Bacon")
    expect(user.password).to eq("pls")
  end
end
