json.extract! order, :id, :price, :number, :canceled, :user_id, :ship_to, :bill_to, :created_at, :updated_at
json.url order_url(order.number, format: :json)