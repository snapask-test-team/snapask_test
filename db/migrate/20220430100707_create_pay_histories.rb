class CreatePayHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :pay_histories do |t|
      t.decimal :total_price, precision: 8, scale: 2, null: false
      t.string :currency
      t.integer :pay_type, null: false
      t.datetime :pay_time

      t.timestamps
    end
  end
end
