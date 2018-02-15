json.extract! community_product, :id, :title, :decrption, :min_price, :reseller_price, :price, :tax_rate, :is_tax_inclusive, :is_featured, :is_private, :is_community_product, :subcategory_id, :image, :product_segment_id, :category_id, :quantity, :created_at, :updated_at
json.url community_product_url(community_product, format: :json)
