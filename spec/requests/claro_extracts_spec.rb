require 'rails_helper'

RSpec.describe "ClaroExtracts", :type => :request do
  describe "GET /claro_extracts" do
    it "works! (now write some real specs)" do
      get claro_extracts_path
      expect(response.status).to be(200)
    end
  end
end
