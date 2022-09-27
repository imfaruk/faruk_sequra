# frozen_string_literal: true

namespace :disbursement do
  desc 'generate dibursement records for each merchant'
  task generate: :environment do
    calculate_at = DateTime.current.beginning_of_day

    Merchant.all.find_each do |merchant|
      GenerateDisbursementService.call(calculate_at:, merchant:)
    end
  end
end
