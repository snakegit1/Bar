require 'rails_helper'

RSpec.describe "api/users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(),
      User.create!()
    ])
  end

  it "renders a list of api/users" do
    render
  end
end
