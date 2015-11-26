require 'rails_helper'

RSpec.describe "type_companies/new", :type => :view do
  before(:each) do
    assign(:type_company, TypeCompany.new(
      :name => "MyString"
    ))
  end

  it "renders new type_company form" do
    render

    assert_select "form[action=?][method=?]", type_companies_path, "post" do

      assert_select "input#type_company_name[name=?]", "type_company[name]"
    end
  end
end
