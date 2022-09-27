# frozen_string_literal: true

class GenerateDisbursementService
  def self.call(calculate_at:, merchant:)
    new(calculate_at, merchant).call
  end

  def call
    return unless orders.any?

    Disbursement.create(merchant: @merchant, amount: amount_to_disburse, calculated_at: calculate_at)
  end

  private

    attr_reader :calculate_at, :merchant

    def initialize(calculate_at, merchant)
      @calculate_at = calculate_at
      @merchant = merchant
    end

    def orders
      @orders ||= Order.where(merchant:, completed_at: disbursement_period)
    end

    def order_total
      @order_total ||= orders.sum(:amount)
    end

    def amount_to_disburse
      DisbursementFeeRule.amount_to_disburse(order_total)
    end

    def disbursement_period
      from = calculate_at.last_week.beginning_of_day
      to = from.next_occurring(:sunday).end_of_day
      from..to
    end
end
