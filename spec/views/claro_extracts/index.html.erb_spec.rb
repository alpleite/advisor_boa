require 'rails_helper'

RSpec.describe "claro_extracts/index", :type => :view do
  before(:each) do
    assign(:claro_extracts, [
      ClaroExtract.create!(
        :line => 1,
        :content => "Content",
        :allotment => nil
      ),
      ClaroExtract.create!(
        :line => 1,
        :content => "Content",
        :allotment => nil
      )
    ])
  end

  it "renders a list of claro_extracts" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
