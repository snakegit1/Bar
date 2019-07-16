require 'rails_helper'

RSpec.describe "api/drink_categories/show", type: :view do
  before(:each) do
    @api_drink_category = assign(:api_drink_category, DrinkCategory.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
