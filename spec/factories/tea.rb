FactoryBot.define do
  factory :subscription do
    title { Faker::Tea.variety }
    temperature { Faker::Number.decimal(l_digits: 2) }
    brew_time { Faker::Number.number(digits: 1) }
  end
end
