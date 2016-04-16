json.array!(@price_items) do |price_item|
  json.extract! price_item, :id, :type, :strike_date, :strike_description, :country, :value, :category
  json.url price_item_url(price_item, format: :json)
end
