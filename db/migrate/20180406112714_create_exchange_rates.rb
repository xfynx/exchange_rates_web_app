class CreateExchangeRates < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_rates do |t|
      t.string :currency
      t.string :cbr_id
      t.float :price
      t.datetime :relevant_until

      t.timestamps
    end
  end
end
