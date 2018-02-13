class AddFieldsToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :product_segment_id, :integer
    add_column :products, :category_id, :integer
  end
end
