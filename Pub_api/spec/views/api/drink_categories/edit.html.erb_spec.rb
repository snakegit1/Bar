require 'rails_helper'

RSpec.describe "api/drink_categories/edit", type: :view do
  before(:each) do
    @api_drink_category = assign(:api_drink_category, DrinkCategory.create!())
  end

  it "renders the edit api_drink_category form" do
    render

    assert_select "form[action=?][method=?]", api_drink_category_path(@api_drink_category), "post" do
    end
  end
end
