class CreateShoppers < ActiveRecord::Migration[7.0]
  def change
    create_table :shoppers do |t|
      t.string :name
      t.string :email, null: false, index: { unique: true }
      t.string :nif, null: false, index: true
      t.timestamps
    end
  end
end
