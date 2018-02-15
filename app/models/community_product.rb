class CommunityProduct < ApplicationRecord
  has_many :community_product_properties, dependent: :destroy
  accepts_nested_attributes_for :community_product_properties
end
