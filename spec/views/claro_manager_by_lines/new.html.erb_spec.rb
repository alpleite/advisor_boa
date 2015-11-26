require 'rails_helper'

RSpec.describe "claro_manager_by_lines/new", :type => :view do
  before(:each) do
    assign(:claro_manager_by_line, ClaroManagerByLine.new(
      :kind => "MyString",
      :item => "MyString",
      :value => "9.99",
      :allotment_id => 1,
      :id_file => "MyString"
    ))
  end

  it "renders new claro_manager_by_line form" do
    render

    assert_select "form[action=?][method=?]", claro_manager_by_lines_path, "post" do

      assert_select "input#claro_manager_by_line_kind[name=?]", "claro_manager_by_line[kind]"

      assert_select "input#claro_manager_by_line_item[name=?]", "claro_manager_by_line[item]"

      assert_select "input#claro_manager_by_line_value[name=?]", "claro_manager_by_line[value]"

      assert_select "input#claro_manager_by_line_allotment_id[name=?]", "claro_manager_by_line[allotment_id]"

      assert_select "input#claro_manager_by_line_id_file[name=?]", "claro_manager_by_line[id_file]"
    end
  end
end
