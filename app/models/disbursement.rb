# frozen_string_literal: true

class Disbursement < ApplicationRecord
  validates :amount, presence: true, numericality: true
  validates :calculated_at, presence: true, uniqueness: { scope: %i[merchant_id] }

  belongs_to :merchant
end
