require 'rails_helper'

RSpec.describe "header_manager_claros/show", :type => :view do
  before(:each) do
    @header_manager_claro = assign(:header_manager_claro, HeaderManagerClaro.create!(
      :name => "Name",
      :item => "Item",
      :tipo => "Tipo",
      :value => "9.99",
      :allotment_id => 1,
      :id_file => "Id File"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Item/)
    expect(rendered).to match(/Tipo/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Id File/)
  end
end
