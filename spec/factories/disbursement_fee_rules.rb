# frozen_string_literal: true

FactoryBot.define do
  factory :disbursement_fee_rule do
    lower_bound { -Float::INFINITY }
    upper_bound { Float::INFINITY }
    percentage { 1.0 }
  end
end
