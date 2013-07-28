# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "MyString"
    body "MyText"
    translation_id 1
    meta_description "MyString"
    published false
  end
end
