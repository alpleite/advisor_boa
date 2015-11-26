# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :allotment do
    name "MyString"
    consumers nil
    status 1
  end
end
