# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    sequence(:email) { |n| "someone#{n}@somewhere.com" }
    sequence(:cif) { |n| "B61111111#{n}" }
  end
end
