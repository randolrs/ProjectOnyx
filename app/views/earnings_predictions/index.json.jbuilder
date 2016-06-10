json.array!(@earnings_predictions) do |earnings_prediction|
  json.extract! earnings_prediction, :id, :company_id, :company, :ticker, :eps_estimate, :quarter, :year, :status, :eps_actual, :rating
  json.url earnings_prediction_url(earnings_prediction, format: :json)
end
