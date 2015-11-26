json.array!(@claro_transaction_by_line_claros) do |claro_transaction_by_line_claro|
  json.extract! claro_transaction_by_line_claro, :id, :name, :kind, :value, :allotment_id, :id_file
  json.url claro_transaction_by_line_claro_url(claro_transaction_by_line_claro, format: :json)
end
