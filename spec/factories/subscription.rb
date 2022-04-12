FactoryBot.define do
  factory :subscription do
    title { Faker::Subscription.plan }
    price { Faker::Commerce.price }
    status { Faker::Subscription.status }
    frequency { Faker::Subscription.subscription_term }
  end
end
