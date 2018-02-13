class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.string :size
      t.string :color
      t.decimal :unit_price
      t.decimal :selling_price
      t.decimal :percent_off

      t.timestamps
    end
  end
end
