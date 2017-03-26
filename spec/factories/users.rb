# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
