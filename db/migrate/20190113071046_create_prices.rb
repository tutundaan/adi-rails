class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.integer :amount, unsigned: true

      t.timestamps
    end
  end
end
