# frozen_string_literal: true

FactoryBot.define do
  factory :disbursement do
    merchant
    amount { 200.0 }
    calculated_at { DateTime.current }
  end
end
