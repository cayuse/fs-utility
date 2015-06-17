# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :condition_category, :class => 'ConditionCategories' do
    condition nil
    category nil
  end
end
