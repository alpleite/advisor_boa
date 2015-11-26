require 'rails_helper'

RSpec.describe "header_manager_claros/index", :type => :view do
  before(:each) do
    assign(:header_manager_claros, [
      HeaderManagerClaro.create!(
        :name => "Name",
        :item => "Item",
        :tipo => "Tipo",
        :value => "9.99",
        :allotment_id => 1,
        :id_file => "Id File"
      ),
      HeaderManagerClaro.create!(
        :name => "Name",
        :item => "Item",
        :tipo => "Tipo",
        :value => "9.99",
        :allotment_id => 1,
        :id_file => "Id File"
      )
    ])
  end

  it "renders a list of header_manager_claros" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Item".to_s, :count => 2
    assert_select "tr>td", :text => "Tipo".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Id File".to_s, :count => 2
  end
end
