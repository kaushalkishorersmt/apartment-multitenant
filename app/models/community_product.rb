class CommunityProduct < ApplicationRecord
  has_many :community_product_properties, dependent: :destroy
  accepts_nested_attributes_for :community_product_properties

  has_many :shop_community_products
  has_many :shops, through: :shop_community_products
end
