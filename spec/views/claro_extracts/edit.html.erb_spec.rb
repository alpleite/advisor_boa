require 'rails_helper'

RSpec.describe "claro_extracts/edit", :type => :view do
  before(:each) do
    @claro_extract = assign(:claro_extract, ClaroExtract.create!(
      :line => 1,
      :content => "MyString",
      :allotment => nil
    ))
  end

  it "renders the edit claro_extract form" do
    render

    assert_select "form[action=?][method=?]", claro_extract_path(@claro_extract), "post" do

      assert_select "input#claro_extract_line[name=?]", "claro_extract[line]"

      assert_select "input#claro_extract_content[name=?]", "claro_extract[content]"

      assert_select "input#claro_extract_allotment_id[name=?]", "claro_extract[allotment_id]"
    end
  end
end
