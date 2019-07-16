require 'rails_helper'

RSpec.describe "Api::Drinks", type: :request do
  describe "GET /api_drinks" do
    it "works! (now write some real specs)" do
      get api_drinks_path
      expect(response).to have_http_status(200)
    end
  end
end
