json.array!(@companies) do |company|
  json.extract! company, :id, :name, :type_companies_id
  json.url company_url(company, format: :json)
end
