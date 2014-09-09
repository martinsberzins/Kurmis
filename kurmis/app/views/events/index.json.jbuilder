json.array!(@events) do |event|
  json.extract! event, :id, :url, :name, :var1, :var2
  json.url event_url(event, format: :json)
end
