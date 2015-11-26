require 'rails_helper'

RSpec.describe "ClaroManagerByLines", :type => :request do
  describe "GET /claro_manager_by_lines" do
    it "works! (now write some real specs)" do
      get claro_manager_by_lines_path
      expect(response.status).to be(200)
    end
  end
end
