json.array!(@data_pdfs) do |data_pdf|
  json.extract! data_pdf, :id
  json.url data_pdf_url(data_pdf, format: :json)
end
