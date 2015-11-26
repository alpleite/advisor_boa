require 'rails_helper'

RSpec.describe "DataPdfs", :type => :request do
  describe "GET /data_pdfs" do
    it "works! (now write some real specs)" do
      get data_pdfs_path
      expect(response.status).to be(200)
    end
  end
end
