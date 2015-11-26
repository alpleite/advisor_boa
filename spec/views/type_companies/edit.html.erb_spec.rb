require 'rails_helper'

RSpec.describe "type_companies/edit", :type => :view do
  before(:each) do
    @type_company = assign(:type_company, TypeCompany.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit type_company form" do
    render

    assert_select "form[action=?][method=?]", type_company_path(@type_company), "post" do

      assert_select "input#type_company_name[name=?]", "type_company[name]"
    end
  end
end
