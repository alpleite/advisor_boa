json.array!(@claro_manager_by_lines) do |claro_manager_by_line|
  json.extract! claro_manager_by_line, :id, :kind, :item, :value, :allotment_id, :id_file
  json.url claro_manager_by_line_url(claro_manager_by_line, format: :json)
end
