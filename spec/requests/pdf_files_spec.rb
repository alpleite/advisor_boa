require 'rails_helper'

RSpec.describe "PdfFiles", :type => :request do
  describe "GET /pdf_files" do
    it "works! (now write some real specs)" do
      get pdf_files_path
      expect(response.status).to be(200)
    end
  end
end
