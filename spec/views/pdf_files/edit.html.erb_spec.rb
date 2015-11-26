require 'rails_helper'

RSpec.describe "pdf_files/edit", :type => :view do
  before(:each) do
    @pdf_file = assign(:pdf_file, PdfFile.create!(
      :name => "MyString",
      :path => "MyString",
      :type => "",
      :allotment => ""
    ))
  end

  it "renders the edit pdf_file form" do
    render

    assert_select "form[action=?][method=?]", pdf_file_path(@pdf_file), "post" do

      assert_select "input#pdf_file_name[name=?]", "pdf_file[name]"

      assert_select "input#pdf_file_path[name=?]", "pdf_file[path]"

      assert_select "input#pdf_file_type[name=?]", "pdf_file[type]"

      assert_select "input#pdf_file_allotment[name=?]", "pdf_file[allotment]"
    end
  end
end
