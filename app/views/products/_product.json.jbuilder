json.extract! product, :id, :name, :description, :unit_price, :available_stock, :entry_date, :deactivation_date, :created_at, :updated_at
json.url product_url(product, format: :json)
