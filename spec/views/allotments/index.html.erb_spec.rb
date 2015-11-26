require 'rails_helper'

RSpec.describe "allotments/index", :type => :view do
  before(:each) do
    assign(:allotments, [
      Allotment.create!(
        :name => "Name",
        :consumers => nil,
        :status => 1
      ),
      Allotment.create!(
        :name => "Name",
        :consumers => nil,
        :status => 1
      )
    ])
  end

  it "renders a list of allotments" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
