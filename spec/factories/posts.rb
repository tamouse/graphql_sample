require "faker"
FactoryGirl.define do
  factory :post do
    account
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraphs.join("\n\n") }
    published false

    factory :published_post do
      published true
      published_at { Time.current }
    end
  end
end
