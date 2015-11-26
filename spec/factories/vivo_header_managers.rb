# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vivo_header_manager do
    allotment nil
    pdf_file nil
    item "MyString"
    number_of_lines 1
    amount_of_plans 1
    contracted_amount "9.99"
    contracted_service "MyString"
    service_used "MyString"
  end
end
