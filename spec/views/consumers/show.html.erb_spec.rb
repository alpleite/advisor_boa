require 'rails_helper'

RSpec.describe "consumers/show", :type => :view do
  before(:each) do
    @consumer = assign(:consumer, Consumer.create!(
      :name => "Name",
      :phone => "Phone"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone/)
  end
end
