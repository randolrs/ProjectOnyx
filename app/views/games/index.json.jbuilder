json.array!(@games) do |game|
  json.extract! game, :id, :teamh, :teama
  json.url game_url(game, format: :json)
end
