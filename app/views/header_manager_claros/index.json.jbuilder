json.array!(@header_manager_claros) do |header_manager_claro|
  json.extract! header_manager_claro, :id, :name, :item, :tipo, :value, :allotment_id, :id_file
  json.url header_manager_claro_url(header_manager_claro, format: :json)
end
