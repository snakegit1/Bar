require 'rails_helper'

RSpec.describe "api/drinks/show", type: :view do
  before(:each) do
    @api_drink = assign(:api_drink, Drink.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
