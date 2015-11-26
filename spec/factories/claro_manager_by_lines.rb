# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :claro_manager_by_line do
    kind "MyString"
    item "MyString"
    value "9.99"
    allotment_id 1
    id_file "MyString"
  end
end
