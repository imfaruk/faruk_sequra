ActiveRecord::Base.transaction do
  merchants = JSON.parse(File.read('./db/seeds/merchants.json'))
  puts 'Creating merchants'
  merchants['RECORDS'].each do |merchant|
    Merchant.create!(merchant)
  end

  shoppers = JSON.parse(File.read('./db/seeds/shoppers.json'))
  puts 'Creating shoppers'
  shoppers['RECORDS'].each do |shopper|
    Shopper.create!(shopper)
  end

  orders = JSON.parse(File.read('./db/seeds/orders.json'))
  puts 'Creating orders'
  orders['RECORDS'].each do |order|
    Order.create!(order)
  end

  puts 'Creating disbursement fee rules'
  DisbursementFeeRule.create(lower_bound: 0.0, upper_bound: 50, percentage: 1)
  DisbursementFeeRule.create(lower_bound: 51.0, upper_bound: 300, percentage: 0.95)
  DisbursementFeeRule.create(lower_bound: 301.0, upper_bound: Float::INFINITY, percentage: 0.85)

  puts 'Creating disbursements'
  merchants =  Merchant.all
  (1..52).to_a.each do |i|
    calculate_at = DateTime.commercial(2018, i, 1)
    merchants.each do |merchant|
      GenerateDisbursementService.call(calculate_at:, merchant:)
    end
  end
end
