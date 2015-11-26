require 'rails_helper'

RSpec.describe "data_pdfs/index", :type => :view do
  before(:each) do
    assign(:data_pdfs, [
      DataPdf.create!(),
      DataPdf.create!()
    ])
  end

  it "renders a list of data_pdfs" do
    render
  end
end
