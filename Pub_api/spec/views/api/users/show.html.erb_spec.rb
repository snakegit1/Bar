require 'rails_helper'

RSpec.describe "api/users/show", type: :view do
  before(:each) do
    @api_user = assign(:api_user, User.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
