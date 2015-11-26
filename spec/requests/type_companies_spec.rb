require 'rails_helper'

RSpec.describe "TypeCompanies", :type => :request do
  describe "GET /type_companies" do
    it "works! (now write some real specs)" do
      get type_companies_path
      expect(response.status).to be(200)
    end
  end
end
