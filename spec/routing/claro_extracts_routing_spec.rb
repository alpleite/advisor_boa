require "rails_helper"

RSpec.describe ClaroExtractsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/claro_extracts").to route_to("claro_extracts#index")
    end

    it "routes to #new" do
      expect(:get => "/claro_extracts/new").to route_to("claro_extracts#new")
    end

    it "routes to #show" do
      expect(:get => "/claro_extracts/1").to route_to("claro_extracts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/claro_extracts/1/edit").to route_to("claro_extracts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/claro_extracts").to route_to("claro_extracts#create")
    end

    it "routes to #update" do
      expect(:put => "/claro_extracts/1").to route_to("claro_extracts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/claro_extracts/1").to route_to("claro_extracts#destroy", :id => "1")
    end

  end
end
