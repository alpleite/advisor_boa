require 'rails_helper'

RSpec.describe "claro_transaction_by_line_claros/edit", :type => :view do
  before(:each) do
    @claro_transaction_by_line_claro = assign(:claro_transaction_by_line_claro, ClaroTransactionByLineClaro.create!(
      :name => "MyString",
      :kind => "MyString",
      :value => "9.99",
      :allotment_id => 1,
      :id_file => "MyString"
    ))
  end

  it "renders the edit claro_transaction_by_line_claro form" do
    render

    assert_select "form[action=?][method=?]", claro_transaction_by_line_claro_path(@claro_transaction_by_line_claro), "post" do

      assert_select "input#claro_transaction_by_line_claro_name[name=?]", "claro_transaction_by_line_claro[name]"

      assert_select "input#claro_transaction_by_line_claro_kind[name=?]", "claro_transaction_by_line_claro[kind]"

      assert_select "input#claro_transaction_by_line_claro_value[name=?]", "claro_transaction_by_line_claro[value]"

      assert_select "input#claro_transaction_by_line_claro_allotment_id[name=?]", "claro_transaction_by_line_claro[allotment_id]"

      assert_select "input#claro_transaction_by_line_claro_id_file[name=?]", "claro_transaction_by_line_claro[id_file]"
    end
  end
end
