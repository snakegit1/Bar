require 'rails_helper'

RSpec.describe "api/drinks/new", type: :view do
  before(:each) do
    assign(:api_drink, Drink.new())
  end

  it "renders new api_drink form" do
    render

    assert_select "form[action=?][method=?]", drinks_path, "post" do
    end
  end
end
