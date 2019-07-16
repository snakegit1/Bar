require "rails_helper"

RSpec.describe Api::DrinkCategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/drink_categories").to route_to("api/drink_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/api/drink_categories/new").to route_to("api/drink_categories#new")
    end

    it "routes to #show" do
      expect(:get => "/api/drink_categories/1").to route_to("api/drink_categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/drink_categories/1/edit").to route_to("api/drink_categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/drink_categories").to route_to("api/drink_categories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/drink_categories/1").to route_to("api/drink_categories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/drink_categories/1").to route_to("api/drink_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/drink_categories/1").to route_to("api/drink_categories#destroy", :id => "1")
    end

  end
end
