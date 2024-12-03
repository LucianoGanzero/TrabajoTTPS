json.extract! product_sold, :id, :sell_price, :quantity, :created_at, :updated_at
json.url product_sold_url(product_sold, format: :json)
