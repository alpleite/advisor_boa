class AddPdfFileToPdfFiles < ActiveRecord::Migration
  def change
    add_column :pdf_files, :pdf_file_id, :string
  end
end
