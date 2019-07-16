require 'rails_helper'

RSpec.describe "api/drink_categories/new", type: :view do
  before(:each) do
    assign(:api_drink_category, DrinkCategory.new())
  end

  it "renders new api_drink_category form" do
    render

    assert_select "form[action=?][method=?]", drink_categories_path, "post" do
    end
  end
end
