require 'rails_helper'

RSpec.describe "data_pdfs/show", :type => :view do
  before(:each) do
    @data_pdf = assign(:data_pdf, DataPdf.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
