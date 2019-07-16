require 'rails_helper'

RSpec.describe "api/pubs/new", type: :view do
  before(:each) do
    assign(:api_pub, Pub.new())
  end

  it "renders new api_pub form" do
    render

    assert_select "form[action=?][method=?]", pubs_path, "post" do
    end
  end
end
