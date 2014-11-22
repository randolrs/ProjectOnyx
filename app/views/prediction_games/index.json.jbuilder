json.array!(@prediction_games) do |prediction_game|
  json.extract! prediction_game, :id, :game_winner, :teama_score, :teamh_score
  json.url prediction_game_url(prediction_game, format: :json)
end
