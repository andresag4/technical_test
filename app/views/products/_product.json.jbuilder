json.extract! product, :id, :name, :tag, :price, :created_at, :updated_at
json.url product_url(product, format: :json)