json.array!(@articles) do |article|
  json.extract! article, :id, :title, :body, :hits
  json.url article_url(article, format: :json)
end
