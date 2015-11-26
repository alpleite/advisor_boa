require "rails_helper"

RSpec.describe TypeCompaniesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/type_companies").to route_to("type_companies#index")
    end

    it "routes to #new" do
      expect(:get => "/type_companies/new").to route_to("type_companies#new")
    end

    it "routes to #show" do
      expect(:get => "/type_companies/1").to route_to("type_companies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/type_companies/1/edit").to route_to("type_companies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/type_companies").to route_to("type_companies#create")
    end

    it "routes to #update" do
      expect(:put => "/type_companies/1").to route_to("type_companies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/type_companies/1").to route_to("type_companies#destroy", :id => "1")
    end

  end
end
