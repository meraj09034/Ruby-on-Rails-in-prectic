json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :qty, :description
  json.url product_url(product, format: :json)
end
