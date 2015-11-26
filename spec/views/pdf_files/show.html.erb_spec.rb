require 'rails_helper'

RSpec.describe "pdf_files/show", :type => :view do
  before(:each) do
    @pdf_file = assign(:pdf_file, PdfFile.create!(
      :name => "Name",
      :path => "Path",
      :type => "Type",
      :allotment => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Path/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(//)
  end
end
