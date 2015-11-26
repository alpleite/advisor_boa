require 'rails_helper'

RSpec.describe "allotments/edit", :type => :view do
  before(:each) do
    @allotment = assign(:allotment, Allotment.create!(
      :name => "MyString",
      :consumers => nil,
      :status => 1
    ))
  end

  it "renders the edit allotment form" do
    render

    assert_select "form[action=?][method=?]", allotment_path(@allotment), "post" do

      assert_select "input#allotment_name[name=?]", "allotment[name]"

      assert_select "input#allotment_consumers_id[name=?]", "allotment[consumers_id]"

      assert_select "input#allotment_status[name=?]", "allotment[status]"
    end
  end
end
