require 'rails_helper'

RSpec.describe "api/pubs/edit", type: :view do
  before(:each) do
    @api_pub = assign(:api_pub, Pub.create!())
  end

  it "renders the edit api_pub form" do
    render

    assert_select "form[action=?][method=?]", api_pub_path(@api_pub), "post" do
    end
  end
end
