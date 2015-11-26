class AddCompanyFromPdfFile < ActiveRecord::Migration
  def change
    add_reference :pdf_files, :company, index: true
    add_foreign_key :pdf_files, :companies
  end
end
