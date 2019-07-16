require 'rails_helper'

RSpec.describe "api/pub_drinks/index", type: :view do
  before(:each) do
    assign(:pub_drinks, [
      PubDrink.create!(),
      PubDrink.create!()
    ])
  end

  it "renders a list of api/pub_drinks" do
    render
  end
end
