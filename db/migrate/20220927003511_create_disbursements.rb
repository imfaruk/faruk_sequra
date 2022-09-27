class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.references :merchant, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.datetime :calculated_at, null: false
      t.timestamps
    end

    add_index :disbursements, %i[calculated_at merchant_id], unique: true
  end
end
