json.extract! order_item, :id, :order_id, :product_id, :quantity, :size, :color, :unit_price, :selling_price, :percent_off, :created_at, :updated_at
json.url order_item_url(order_item, format: :json)
