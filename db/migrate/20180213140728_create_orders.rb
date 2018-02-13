class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.string :payment_id
      t.string :payment_status
      t.string :order_reference
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
