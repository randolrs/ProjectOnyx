json.array!(@plans) do |plan|
  json.extract! plan, :id, :stripe_id, :description, :cost
  json.url plan_url(plan, format: :json)
end
