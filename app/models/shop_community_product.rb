class ShopCommunityProduct < ApplicationRecord
  belongs_to :shop
  belongs_to :community_product
end
