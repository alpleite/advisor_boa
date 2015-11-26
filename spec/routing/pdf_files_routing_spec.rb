require "rails_helper"

RSpec.describe PdfFilesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pdf_files").to route_to("pdf_files#index")
    end

    it "routes to #new" do
      expect(:get => "/pdf_files/new").to route_to("pdf_files#new")
    end

    it "routes to #show" do
      expect(:get => "/pdf_files/1").to route_to("pdf_files#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pdf_files/1/edit").to route_to("pdf_files#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pdf_files").to route_to("pdf_files#create")
    end

    it "routes to #update" do
      expect(:put => "/pdf_files/1").to route_to("pdf_files#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pdf_files/1").to route_to("pdf_files#destroy", :id => "1")
    end

  end
end
