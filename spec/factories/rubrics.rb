require 'faker'
FactoryGirl.define do
  factory :rubric do
    title {Faker::Lorem.words(2).join(' ')}
    language SUPPORTED_LANGUAGES.keys.first.to_s
  end
end
