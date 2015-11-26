require 'rails_helper'

RSpec.describe "claro_transaction_by_line_claros/index", :type => :view do
  before(:each) do
    assign(:claro_transaction_by_line_claros, [
      ClaroTransactionByLineClaro.create!(
        :name => "Name",
        :kind => "Kind",
        :value => "9.99",
        :allotment_id => 1,
        :id_file => "Id File"
      ),
      ClaroTransactionByLineClaro.create!(
        :name => "Name",
        :kind => "Kind",
        :value => "9.99",
        :allotment_id => 1,
        :id_file => "Id File"
      )
    ])
  end

  it "renders a list of claro_transaction_by_line_claros" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Id File".to_s, :count => 2
  end
end
