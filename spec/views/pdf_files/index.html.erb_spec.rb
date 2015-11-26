require 'rails_helper'

RSpec.describe "pdf_files/index", :type => :view do
  before(:each) do
    assign(:pdf_files, [
      PdfFile.create!(
        :name => "Name",
        :path => "Path",
        :type => "Type",
        :allotment => ""
      ),
      PdfFile.create!(
        :name => "Name",
        :path => "Path",
        :type => "Type",
        :allotment => ""
      )
    ])
  end

  it "renders a list of pdf_files" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
