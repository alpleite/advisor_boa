require "rails_helper"

RSpec.describe AllotmentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/allotments").to route_to("allotments#index")
    end

    it "routes to #new" do
      expect(:get => "/allotments/new").to route_to("allotments#new")
    end

    it "routes to #show" do
      expect(:get => "/allotments/1").to route_to("allotments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/allotments/1/edit").to route_to("allotments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/allotments").to route_to("allotments#create")
    end

    it "routes to #update" do
      expect(:put => "/allotments/1").to route_to("allotments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/allotments/1").to route_to("allotments#destroy", :id => "1")
    end

  end
end
