require 'rails_helper'

RSpec.describe "claro_extracts/new", :type => :view do
  before(:each) do
    assign(:claro_extract, ClaroExtract.new(
      :line => 1,
      :content => "MyString",
      :allotment => nil
    ))
  end

  it "renders new claro_extract form" do
    render

    assert_select "form[action=?][method=?]", claro_extracts_path, "post" do

      assert_select "input#claro_extract_line[name=?]", "claro_extract[line]"

      assert_select "input#claro_extract_content[name=?]", "claro_extract[content]"

      assert_select "input#claro_extract_allotment_id[name=?]", "claro_extract[allotment_id]"
    end
  end
end
