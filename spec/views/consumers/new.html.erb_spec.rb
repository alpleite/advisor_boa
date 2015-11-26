require 'rails_helper'

RSpec.describe "consumers/new", :type => :view do
  before(:each) do
    assign(:consumer, Consumer.new(
      :name => "MyString",
      :phone => "MyString"
    ))
  end

  it "renders new consumer form" do
    render

    assert_select "form[action=?][method=?]", consumers_path, "post" do

      assert_select "input#consumer_name[name=?]", "consumer[name]"

      assert_select "input#consumer_phone[name=?]", "consumer[phone]"
    end
  end
end
