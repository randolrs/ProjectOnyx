json.array!(@prediction_economies) do |prediction_economy|
  json.extract! prediction_economy, :id, :type, :type_id, :strike_date, :strike_description, :country, :value
  json.url prediction_economy_url(prediction_economy, format: :json)
end
