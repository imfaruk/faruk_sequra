class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :merchant, null: false
      t.references :shopper, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.datetime :completed_at
      t.timestamps
    end
  end
end
