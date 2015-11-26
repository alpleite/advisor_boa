require 'rails_helper'

RSpec.describe "header_manager_claros/new", :type => :view do
  before(:each) do
    assign(:header_manager_claro, HeaderManagerClaro.new(
      :name => "MyString",
      :item => "MyString",
      :tipo => "MyString",
      :value => "9.99",
      :allotment_id => 1,
      :id_file => "MyString"
    ))
  end

  it "renders new header_manager_claro form" do
    render

    assert_select "form[action=?][method=?]", header_manager_claros_path, "post" do

      assert_select "input#header_manager_claro_name[name=?]", "header_manager_claro[name]"

      assert_select "input#header_manager_claro_item[name=?]", "header_manager_claro[item]"

      assert_select "input#header_manager_claro_tipo[name=?]", "header_manager_claro[tipo]"

      assert_select "input#header_manager_claro_value[name=?]", "header_manager_claro[value]"

      assert_select "input#header_manager_claro_allotment_id[name=?]", "header_manager_claro[allotment_id]"

      assert_select "input#header_manager_claro_id_file[name=?]", "header_manager_claro[id_file]"
    end
  end
end
