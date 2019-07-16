require "rails_helper"

RSpec.describe Api::PubDrinksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/pub_drinks").to route_to("api/pub_drinks#index")
    end

    it "routes to #new" do
      expect(:get => "/api/pub_drinks/new").to route_to("api/pub_drinks#new")
    end

    it "routes to #show" do
      expect(:get => "/api/pub_drinks/1").to route_to("api/pub_drinks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/pub_drinks/1/edit").to route_to("api/pub_drinks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/pub_drinks").to route_to("api/pub_drinks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/pub_drinks/1").to route_to("api/pub_drinks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/pub_drinks/1").to route_to("api/pub_drinks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/pub_drinks/1").to route_to("api/pub_drinks#destroy", :id => "1")
    end

  end
end
