# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :claro_transaction_by_line_claro do
    name "MyString"
    kind "MyString"
    value "9.99"
    allotment_id 1
    id_file "MyString"
  end
end
