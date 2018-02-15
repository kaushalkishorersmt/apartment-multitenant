class CreateShopCommunityProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :shop_community_products do |t|
      t.references :shop, foreign_key: true
      t.references :community_product, foreign_key: true

      t.timestamps
    end
  end
end
