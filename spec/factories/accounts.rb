require "faker"
FactoryGirl.define do
  factory :account do
    name { Faker::Name.name }
  end
end
