# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :admin_user do
    email {Faker::Internet.email}
    password 'TestPassw0rd'
  end
end
