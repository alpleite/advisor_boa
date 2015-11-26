require 'rails_helper'

RSpec.describe "claro_extracts/show", :type => :view do
  before(:each) do
    @claro_extract = assign(:claro_extract, ClaroExtract.create!(
      :line => 1,
      :content => "Content",
      :allotment => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Content/)
    expect(rendered).to match(//)
  end
end
