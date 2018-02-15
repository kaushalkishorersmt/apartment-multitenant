class AddFieldsToCommunityProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :community_products, :source, :string
    add_column :community_products, :source_product_id, :integer
  end
end
