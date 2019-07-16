require 'rails_helper'

RSpec.describe "api/users/edit", type: :view do
  before(:each) do
    @api_user = assign(:api_user, User.create!())
  end

  it "renders the edit api_user form" do
    render

    assert_select "form[action=?][method=?]", api_user_path(@api_user), "post" do
    end
  end
end
