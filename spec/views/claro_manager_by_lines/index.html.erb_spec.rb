require 'rails_helper'

RSpec.describe "claro_manager_by_lines/index", :type => :view do
  before(:each) do
    assign(:claro_manager_by_lines, [
      ClaroManagerByLine.create!(
        :kind => "Kind",
        :item => "Item",
        :value => "9.99",
        :allotment_id => 1,
        :id_file => "Id File"
      ),
      ClaroManagerByLine.create!(
        :kind => "Kind",
        :item => "Item",
        :value => "9.99",
        :allotment_id => 1,
        :id_file => "Id File"
      )
    ])
  end

  it "renders a list of claro_manager_by_lines" do
    render
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
    assert_select "tr>td", :text => "Item".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Id File".to_s, :count => 2
  end
end
