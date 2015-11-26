json.array!(@type_companies) do |type_company|
  json.extract! type_company, :id, :name
  json.url type_company_url(type_company, format: :json)
end
