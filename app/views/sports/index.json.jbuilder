json.array!(@sports) do |sport|
  json.extract! sport, :id, :subcat
  json.url sport_url(sport, format: :json)
end
