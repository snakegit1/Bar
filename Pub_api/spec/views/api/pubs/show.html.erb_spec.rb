require 'rails_helper'

RSpec.describe "api/pubs/show", type: :view do
  before(:each) do
    @api_pub = assign(:api_pub, Pub.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
