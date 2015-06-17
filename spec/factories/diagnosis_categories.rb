# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diagnosis_category, :class => 'DiagnosisCategories' do
    diagnosis nil
    category nil
  end
end
