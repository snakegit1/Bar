require 'rails_helper'

RSpec.describe "api/pub_drinks/edit", type: :view do
  before(:each) do
    @api_pub_drink = assign(:api_pub_drink, PubDrink.create!())
  end

  it "renders the edit api_pub_drink form" do
    render

    assert_select "form[action=?][method=?]", api_pub_drink_path(@api_pub_drink), "post" do
    end
  end
end
