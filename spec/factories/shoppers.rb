# frozen_string_literal: true

FactoryBot.define do
  factory :shopper do
    sequence(:email) { |n| "someone@somewhere#{n}.com" }
    sequence(:nif) { |n| "#{n}11111111Z" }
  end
end
