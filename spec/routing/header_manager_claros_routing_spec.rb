require "rails_helper"

RSpec.describe HeaderManagerClarosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/header_manager_claros").to route_to("header_manager_claros#index")
    end

    it "routes to #new" do
      expect(:get => "/header_manager_claros/new").to route_to("header_manager_claros#new")
    end

    it "routes to #show" do
      expect(:get => "/header_manager_claros/1").to route_to("header_manager_claros#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/header_manager_claros/1/edit").to route_to("header_manager_claros#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/header_manager_claros").to route_to("header_manager_claros#create")
    end

    it "routes to #update" do
      expect(:put => "/header_manager_claros/1").to route_to("header_manager_claros#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/header_manager_claros/1").to route_to("header_manager_claros#destroy", :id => "1")
    end

  end
end
