json.array!(@tags) do |tag|
  json.extract! tag, :id, :tagname
  json.url tag_url(tag, format: :json)
end
