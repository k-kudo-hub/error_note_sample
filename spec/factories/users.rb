# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    confirmation_token     { nil }
    confirmation_sent_at   { nil }
    email                  { 'foo@example.com' }
    introduce              { Faker::Lorem.characters(number: 40) }
    name                   { Faker::Name.initials(number: 5) }
    password               { 'pass1234' }
    password_confirmation  { password }
    picture                { nil }
    reset_password_token   { nil }
    reset_password_sent_at { nil }
    remember_created_at    { nil }
    unconfirmed_email      { nil }
  end
end
