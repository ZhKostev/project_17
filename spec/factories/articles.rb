# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.words(4).join(' ') }
    body Faker::Lorem.paragraphs(2).join(' \n ')
    short_description Faker::Lorem.paragraphs(1)
    published true
    language SUPPORTED_LANGUAGES.keys.first.to_s
  end
end
