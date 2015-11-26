json.array!(@allotments) do |allotment|
  json.extract! allotment, :id, :name, :consumers_id, :status
  json.url allotment_url(allotment, format: :json)
end
