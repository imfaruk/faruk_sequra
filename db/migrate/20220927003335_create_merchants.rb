class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :email, null: false, index: { unique: true }
      t.string :cif, null: false, index: true
      t.timestamps
    end
  end
end
