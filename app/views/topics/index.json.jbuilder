json.array!(@topics) do |topic|
  json.extract! topic, :id, :name, :url, :parent_tag_id
  json.url topic_url(topic, format: :json)
end
