json.extract! sale, :id, :total_price, :client, :created_at, :updated_at
json.url sale_url(sale, format: :json)
