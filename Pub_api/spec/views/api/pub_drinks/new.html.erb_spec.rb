require 'rails_helper'

RSpec.describe "api/pub_drinks/new", type: :view do
  before(:each) do
    assign(:api_pub_drink, PubDrink.new())
  end

  it "renders new api_pub_drink form" do
    render

    assert_select "form[action=?][method=?]", pub_drinks_path, "post" do
    end
  end
end
