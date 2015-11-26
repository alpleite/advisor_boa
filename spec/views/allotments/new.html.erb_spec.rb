require 'rails_helper'

RSpec.describe "allotments/new", :type => :view do
  before(:each) do
    assign(:allotment, Allotment.new(
      :name => "MyString",
      :consumers => nil,
      :status => 1
    ))
  end

  it "renders new allotment form" do
    render

    assert_select "form[action=?][method=?]", allotments_path, "post" do

      assert_select "input#allotment_name[name=?]", "allotment[name]"

      assert_select "input#allotment_consumers_id[name=?]", "allotment[consumers_id]"

      assert_select "input#allotment_status[name=?]", "allotment[status]"
    end
  end
end
