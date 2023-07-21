# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :invalid_user, parent: :user do
    name { nil }
    last_name { nil }
    email { nil }
    password { nil }
  end
end
