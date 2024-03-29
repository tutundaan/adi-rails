class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :price
      t.integer :number
      t.boolean :canceled
      t.belongs_to :user, foreign_key: true
      t.belongs_to :address, foreign_key: true

      t.timestamps
    end
  end
end
