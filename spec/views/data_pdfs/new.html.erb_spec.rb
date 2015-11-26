require 'rails_helper'

RSpec.describe "data_pdfs/new", :type => :view do
  before(:each) do
    assign(:data_pdf, DataPdf.new())
  end

  it "renders new data_pdf form" do
    render

    assert_select "form[action=?][method=?]", data_pdfs_path, "post" do
    end
  end
end
