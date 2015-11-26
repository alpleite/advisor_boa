require 'rails_helper'

RSpec.describe "consumers/edit", :type => :view do
  before(:each) do
    @consumer = assign(:consumer, Consumer.create!(
      :name => "MyString",
      :phone => "MyString"
    ))
  end

  it "renders the edit consumer form" do
    render

    assert_select "form[action=?][method=?]", consumer_path(@consumer), "post" do

      assert_select "input#consumer_name[name=?]", "consumer[name]"

      assert_select "input#consumer_phone[name=?]", "consumer[phone]"
    end
  end
end
