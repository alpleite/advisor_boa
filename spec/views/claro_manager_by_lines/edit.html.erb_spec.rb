require 'rails_helper'

RSpec.describe "claro_manager_by_lines/edit", :type => :view do
  before(:each) do
    @claro_manager_by_line = assign(:claro_manager_by_line, ClaroManagerByLine.create!(
      :kind => "MyString",
      :item => "MyString",
      :value => "9.99",
      :allotment_id => 1,
      :id_file => "MyString"
    ))
  end

  it "renders the edit claro_manager_by_line form" do
    render

    assert_select "form[action=?][method=?]", claro_manager_by_line_path(@claro_manager_by_line), "post" do

      assert_select "input#claro_manager_by_line_kind[name=?]", "claro_manager_by_line[kind]"

      assert_select "input#claro_manager_by_line_item[name=?]", "claro_manager_by_line[item]"

      assert_select "input#claro_manager_by_line_value[name=?]", "claro_manager_by_line[value]"

      assert_select "input#claro_manager_by_line_allotment_id[name=?]", "claro_manager_by_line[allotment_id]"

      assert_select "input#claro_manager_by_line_id_file[name=?]", "claro_manager_by_line[id_file]"
    end
  end
end
