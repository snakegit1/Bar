require 'rails_helper'

RSpec.describe "api/drink_categories/index", type: :view do
  before(:each) do
    assign(:drink_categories, [
      DrinkCategory.create!(),
      DrinkCategory.create!()
    ])
  end

  it "renders a list of api/drink_categories" do
    render
  end
end
