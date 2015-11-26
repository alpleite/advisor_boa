json.array!(@consumers) do |consumer|
  json.extract! consumer, :id, :name, :phone
  json.url consumer_url(consumer, format: :json)
end
