require "rails_helper"

RSpec.describe Api::DrinksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/drinks").to route_to("api/drinks#index")
    end

    it "routes to #new" do
      expect(:get => "/api/drinks/new").to route_to("api/drinks#new")
    end

    it "routes to #show" do
      expect(:get => "/api/drinks/1").to route_to("api/drinks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/drinks/1/edit").to route_to("api/drinks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/drinks").to route_to("api/drinks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/drinks/1").to route_to("api/drinks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/drinks/1").to route_to("api/drinks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/drinks/1").to route_to("api/drinks#destroy", :id => "1")
    end

  end
end
