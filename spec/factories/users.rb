# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
