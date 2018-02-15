class CreateCommunityProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :community_products do |t|
      t.string :title
      t.text :decrption
      t.decimal :min_price
      t.decimal :reseller_price
      t.decimal :price
      t.decimal :tax_rate
      t.boolean :is_tax_inclusive
      t.boolean :is_featured
      t.boolean :is_private
      t.boolean :is_community_product
      t.integer :subcategory_id
      t.string :image, array: true, default: []
      t.integer :product_segment_id
      t.integer :category_id
      t.integer :quantity

      t.timestamps
    end
  end
end
