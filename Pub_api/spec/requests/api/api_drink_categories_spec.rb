require 'rails_helper'

RSpec.describe "Api::DrinkCategories", type: :request do
  describe "GET /api_drink_categories" do
    it "works! (now write some real specs)" do
      get api_drink_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
