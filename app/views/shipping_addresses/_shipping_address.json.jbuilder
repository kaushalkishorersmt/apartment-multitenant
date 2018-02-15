json.extract! shipping_address, :id, :line1, :line2, :zipcode, :city, :state, :country, :customer_id, :created_at, :updated_at
json.url shipping_address_url(shipping_address, format: :json)
