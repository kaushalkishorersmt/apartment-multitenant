class CreateShippingAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_addresses do |t|
      t.string :line1
      t.string :line2
      t.string :zipcode
      t.string :city
      t.string :state
      t.string :country
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
