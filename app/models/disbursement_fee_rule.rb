# frozen_string_literal: true

class DisbursementFeeRule < ApplicationRecord
  validates :lower_bound, presence: true, numericality: true
  validates :upper_bound, presence: true, numericality: true
  validates :percentage, presence: true, numericality: true

  validate :upper_and_lower_limit
  validate :upper_is_greater_than_lower

  def self.amount_to_disburse(amount)
    disbursement_rule = DisbursementFeeRule.where(':amount >= lower_bound AND :amount <= upper_bound', amount:).first
    disbursement_rule.amount_to_disburse(amount)
  end

  def amount_to_disburse(amount)
    amount * percentage / 100
  end

  private

    def upper_and_lower_limit
      return if upper_bound.blank? || lower_bound.blank?

      limits = DisbursementFeeRule.pluck('min(lower_bound), max(lower_bound), min(upper_bound), max(upper_bound)').first
      return unless limits.any?

      min_lower, max_lower, min_upper, max_upper = limits

      if lower_bound < min_lower && upper_bound < min_lower || lower_bound > min_upper && upper_bound < max_lower || lower_bound > max_upper && upper_bound > max_upper
        return
      end

      errors.add(:base, 'Invalid upper and/or lower bound limit')
    end

    def upper_is_greater_than_lower
      return if upper_bound.blank? || lower_bound.blank?

      return if lower_bound < upper_bound

      errors.add(:base, 'lower bound must be less than upper bound')
    end
end
