require 'rails_helper'

RSpec.describe "pdf_files/new", :type => :view do
  before(:each) do
    assign(:pdf_file, PdfFile.new(
      :name => "MyString",
      :path => "MyString",
      :type => "",
      :allotment => ""
    ))
  end

  it "renders new pdf_file form" do
    render

    assert_select "form[action=?][method=?]", pdf_files_path, "post" do

      assert_select "input#pdf_file_name[name=?]", "pdf_file[name]"

      assert_select "input#pdf_file_path[name=?]", "pdf_file[path]"

      assert_select "input#pdf_file_type[name=?]", "pdf_file[type]"

      assert_select "input#pdf_file_allotment[name=?]", "pdf_file[allotment]"
    end
  end
end
