json.array!(@claro_transaction_by_lines) do |claro_transaction_by_line|
  json.extract! claro_transaction_by_line, :id, :name, :kind, :value, :use_time, :allotment_id, :id_file
  json.url claro_transaction_by_line_url(claro_transaction_by_line, format: :json)
end
