class CreateDisbursementFeeRules < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursement_fee_rules do |t|
      t.float :upper_bound, null: false
      t.float :lower_bound, null: false
      t.float :percentage, null: false
      t.timestamps
    end
  end
end
