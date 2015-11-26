require "rails_helper"

RSpec.describe ClaroTransactionByLineClarosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/claro_transaction_by_line_claros").to route_to("claro_transaction_by_line_claros#index")
    end

    it "routes to #new" do
      expect(:get => "/claro_transaction_by_line_claros/new").to route_to("claro_transaction_by_line_claros#new")
    end

    it "routes to #show" do
      expect(:get => "/claro_transaction_by_line_claros/1").to route_to("claro_transaction_by_line_claros#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/claro_transaction_by_line_claros/1/edit").to route_to("claro_transaction_by_line_claros#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/claro_transaction_by_line_claros").to route_to("claro_transaction_by_line_claros#create")
    end

    it "routes to #update" do
      expect(:put => "/claro_transaction_by_line_claros/1").to route_to("claro_transaction_by_line_claros#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/claro_transaction_by_line_claros/1").to route_to("claro_transaction_by_line_claros#destroy", :id => "1")
    end

  end
end
