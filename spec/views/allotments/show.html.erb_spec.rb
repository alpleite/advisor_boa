require 'rails_helper'

RSpec.describe "allotments/show", :type => :view do
  before(:each) do
    @allotment = assign(:allotment, Allotment.create!(
      :name => "Name",
      :consumers => nil,
      :status => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
  end
end
