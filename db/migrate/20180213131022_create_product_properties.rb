class CreateProductProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :product_properties do |t|
      t.references :product, foreign_key: true
      t.string :size
      t.string :color
      t.integer :quantity

      t.timestamps
    end
  end
end
