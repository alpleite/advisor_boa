require 'rails_helper'

RSpec.describe "claro_transaction_by_line_claros/show", :type => :view do
  before(:each) do
    @claro_transaction_by_line_claro = assign(:claro_transaction_by_line_claro, ClaroTransactionByLineClaro.create!(
      :name => "Name",
      :kind => "Kind",
      :value => "9.99",
      :allotment_id => 1,
      :id_file => "Id File"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Kind/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Id File/)
  end
end
