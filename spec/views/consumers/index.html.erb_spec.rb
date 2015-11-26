require 'rails_helper'

RSpec.describe "consumers/index", :type => :view do
  before(:each) do
    assign(:consumers, [
      Consumer.create!(
        :name => "Name",
        :phone => "Phone"
      ),
      Consumer.create!(
        :name => "Name",
        :phone => "Phone"
      )
    ])
  end

  it "renders a list of consumers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
  end
end
