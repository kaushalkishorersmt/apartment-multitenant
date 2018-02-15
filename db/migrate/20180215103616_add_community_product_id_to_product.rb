class AddCommunityProductIdToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :community_product_id, :integer
  end
end
