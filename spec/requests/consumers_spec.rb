require 'rails_helper'

RSpec.describe "Consumers", :type => :request do
  describe "GET /consumers" do
    it "works! (now write some real specs)" do
      get consumers_path
      expect(response.status).to be(200)
    end
  end
end
