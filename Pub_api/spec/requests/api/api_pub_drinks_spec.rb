require 'rails_helper'

RSpec.describe "Api::PubDrinks", type: :request do
  describe "GET /api_pub_drinks" do
    it "works! (now write some real specs)" do
      get api_pub_drinks_path
      expect(response).to have_http_status(200)
    end
  end
end
