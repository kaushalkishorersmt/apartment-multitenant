class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title,          null: false
      t.text :decrption
      t.decimal :min_price
      t.decimal :reseller_price
      t.decimal :price
      t.decimal :tax_rate
      t.boolean :is_tax_inclusive
      t.boolean :is_featured
      t.boolean :is_private
      t.boolean :is_community_product
      t.references :subcategory
      t.string :image, array: true, default: []

      t.timestamps
    end
  end
end
