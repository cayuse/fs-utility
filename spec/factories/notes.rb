# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    student "MyString"
    references "MyString"
    entry "MyString"
    text "MyString"
  end
end
