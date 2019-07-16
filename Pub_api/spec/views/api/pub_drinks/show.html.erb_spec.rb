require 'rails_helper'

RSpec.describe "api/pub_drinks/show", type: :view do
  before(:each) do
    @api_pub_drink = assign(:api_pub_drink, PubDrink.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
