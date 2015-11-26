require 'rails_helper'

RSpec.describe "claro_manager_by_lines/show", :type => :view do
  before(:each) do
    @claro_manager_by_line = assign(:claro_manager_by_line, ClaroManagerByLine.create!(
      :kind => "Kind",
      :item => "Item",
      :value => "9.99",
      :allotment_id => 1,
      :id_file => "Id File"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Kind/)
    expect(rendered).to match(/Item/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Id File/)
  end
end
