class CreateCommunityProductProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :community_product_properties do |t|
      t.references :community_product, foreign_key: true
      t.string :size
      t.string :color
      t.integer :quantity

      t.timestamps
    end
  end
end
