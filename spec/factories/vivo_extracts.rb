# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vivo_extract do
    allotment nil
    pdf_file nil
    line 1
    content "MyString"
  end
end
