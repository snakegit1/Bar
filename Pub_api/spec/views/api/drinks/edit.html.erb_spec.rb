require 'rails_helper'

RSpec.describe "api/drinks/edit", type: :view do
  before(:each) do
    @api_drink = assign(:api_drink, Drink.create!())
  end

  it "renders the edit api_drink form" do
    render

    assert_select "form[action=?][method=?]", api_drink_path(@api_drink), "post" do
    end
  end
end
