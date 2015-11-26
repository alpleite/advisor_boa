require 'rails_helper'

RSpec.describe "type_companies/index", :type => :view do
  before(:each) do
    assign(:type_companies, [
      TypeCompany.create!(
        :name => "Name"
      ),
      TypeCompany.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of type_companies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
