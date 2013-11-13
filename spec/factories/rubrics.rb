require 'faker'
FactoryGirl.define do
  factory :rubric do
    title {Faker::Lorem.words(2)}
    language SUPPORTED_LANGUAGES.keys.first
  end
end
