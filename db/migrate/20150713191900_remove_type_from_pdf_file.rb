class RemoveTypeFromPdfFile < ActiveRecord::Migration
  def change
    remove_column :pdf_files, :type, :string
  end
end
