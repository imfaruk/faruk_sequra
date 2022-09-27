# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    merchant
    shopper
    amount { 200.0 }
    completed_at { DateTime.current.last_week }
  end
end
