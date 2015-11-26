require 'rails_helper'

RSpec.describe "type_companies/show", :type => :view do
  before(:each) do
    @type_company = assign(:type_company, TypeCompany.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
