require 'rails_helper'

RSpec.describe "claro_transaction_by_lines/new", :type => :view do
  before(:each) do
    assign(:claro_transaction_by_line, ClaroTransactionByLine.new(
      :name => "MyString",
      :kind => "MyString",
      :value => "9.99",
      :use_time => "9.99",
      :allotment_id => 1,
      :id_file => "MyString"
    ))
  end

  it "renders new claro_transaction_by_line form" do
    render

    assert_select "form[action=?][method=?]", claro_transaction_by_lines_path, "post" do

      assert_select "input#claro_transaction_by_line_name[name=?]", "claro_transaction_by_line[name]"

      assert_select "input#claro_transaction_by_line_kind[name=?]", "claro_transaction_by_line[kind]"

      assert_select "input#claro_transaction_by_line_value[name=?]", "claro_transaction_by_line[value]"

      assert_select "input#claro_transaction_by_line_use_time[name=?]", "claro_transaction_by_line[use_time]"

      assert_select "input#claro_transaction_by_line_allotment_id[name=?]", "claro_transaction_by_line[allotment_id]"

      assert_select "input#claro_transaction_by_line_id_file[name=?]", "claro_transaction_by_line[id_file]"
    end
  end
end
