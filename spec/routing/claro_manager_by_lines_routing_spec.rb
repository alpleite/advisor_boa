require "rails_helper"

RSpec.describe ClaroManagerByLinesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/claro_manager_by_lines").to route_to("claro_manager_by_lines#index")
    end

    it "routes to #new" do
      expect(:get => "/claro_manager_by_lines/new").to route_to("claro_manager_by_lines#new")
    end

    it "routes to #show" do
      expect(:get => "/claro_manager_by_lines/1").to route_to("claro_manager_by_lines#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/claro_manager_by_lines/1/edit").to route_to("claro_manager_by_lines#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/claro_manager_by_lines").to route_to("claro_manager_by_lines#create")
    end

    it "routes to #update" do
      expect(:put => "/claro_manager_by_lines/1").to route_to("claro_manager_by_lines#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/claro_manager_by_lines/1").to route_to("claro_manager_by_lines#destroy", :id => "1")
    end

  end
end
