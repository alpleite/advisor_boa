require 'rails_helper'

RSpec.describe "HeaderManagerClaros", :type => :request do
  describe "GET /header_manager_claros" do
    it "works! (now write some real specs)" do
      get header_manager_claros_path
      expect(response.status).to be(200)
    end
  end
end
