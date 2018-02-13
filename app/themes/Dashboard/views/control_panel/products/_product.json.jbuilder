json.extract! product, :id, :title, :decrption, :min_price, :reseller_price, :price, :tax_rate, :is_tax_inclusive, :is_featured, :is_private, :is_community_product, :subcategory, :image, :created_at, :updated_at
json.url product_url(product, format: :json)
