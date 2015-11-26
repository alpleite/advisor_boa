require 'rails_helper'

RSpec.describe "data_pdfs/edit", :type => :view do
  before(:each) do
    @data_pdf = assign(:data_pdf, DataPdf.create!())
  end

  it "renders the edit data_pdf form" do
    render

    assert_select "form[action=?][method=?]", data_pdf_path(@data_pdf), "post" do
    end
  end
end
