# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :article do
    title {Faker::Lorem.words(4)}
    body Faker::Lorem.paragraphs(2)
    short_description Faker::Lorem.paragraphs(1)
    published false
  end
end
