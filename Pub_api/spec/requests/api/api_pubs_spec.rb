require 'rails_helper'

RSpec.describe "Api::Pubs", type: :request do
  describe "GET /api_pubs" do
    it "works! (now write some real specs)" do
      get api_pubs_path
      expect(response).to have_http_status(200)
    end
  end
end
