json.array!(@predictions) do |prediction|
  json.extract! prediction, :id, :event
  json.url prediction_url(prediction, format: :json)
end
