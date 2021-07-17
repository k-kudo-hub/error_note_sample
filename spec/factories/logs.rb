FactoryBot.define do
  factory :log do
    user        { FactoryBot.build(:user) }
    title       { Faker::Lorem.characters(number: 10) }
    error       { Faker::Lorem.characters(number: 40) }
    solution    { Faker::Lorem.characters(number: 40) }
    release     { Faker::Boolean.boolean }
  end
end
