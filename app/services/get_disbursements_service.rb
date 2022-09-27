# frozen_string_literal: true

class GetDisbursementsService
  attr_reader :calculated_at, :merchant_id

  def self.call(week:, year:, merchant_id: nil)
    new(week, year, merchant_id).call
  end

  def initialize(week, year, merchant_id)
    @calculated_at = DateTime.commercial(year, week, 1)
    @merchant_id = merchant_id
  end

  def call
    if merchant_id.present?
      Disbursement.find_by(calculated_at:, merchant_id:)
    else
      Disbursement.where(calculated_at:)
    end
  end
end
