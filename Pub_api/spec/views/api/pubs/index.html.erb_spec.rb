require 'rails_helper'

RSpec.describe "api/pubs/index", type: :view do
  before(:each) do
    assign(:pubs, [
      Pub.create!(),
      Pub.create!()
    ])
  end

  it "renders a list of api/pubs" do
    render
  end
end
