require "rails_helper"

RSpec.describe Api::PubsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/pubs").to route_to("api/pubs#index")
    end

    it "routes to #new" do
      expect(:get => "/api/pubs/new").to route_to("api/pubs#new")
    end

    it "routes to #show" do
      expect(:get => "/api/pubs/1").to route_to("api/pubs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/pubs/1/edit").to route_to("api/pubs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/pubs").to route_to("api/pubs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/pubs/1").to route_to("api/pubs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/pubs/1").to route_to("api/pubs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/pubs/1").to route_to("api/pubs#destroy", :id => "1")
    end

  end
end
