json.array!(@topic_copies) do |topic_copy|
  json.extract! topic_copy, :id, :headline_1, :headline_2, :headline_3, :topic_id
  json.url topic_copy_url(topic_copy, format: :json)
end
