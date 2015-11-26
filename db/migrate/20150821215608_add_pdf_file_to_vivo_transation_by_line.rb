class AddPdfFileToVivoTransationByLine < ActiveRecord::Migration
  def change
    add_reference :vivo_transation_by_lines, :pdf_file, index: true
    add_foreign_key :vivo_transation_by_lines, :pdf_files
  end
end
