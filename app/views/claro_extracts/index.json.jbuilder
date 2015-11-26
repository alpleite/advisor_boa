json.array!(@claro_extracts) do |claro_extract|
  json.extract! claro_extract, :id, :line, :content, :allotment_id
  json.url claro_extract_url(claro_extract, format: :json)
end
