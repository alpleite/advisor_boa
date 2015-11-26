class CreatePdfFiles < ActiveRecord::Migration
  def change
    create_table :pdf_files do |t|
      t.string :name
      t.string :path
      t.string :type
      t.references :allotments, index: true

      t.timestamps null: false
    end
    add_foreign_key :pdf_files, :allotments , column: :allotments_id
  end
end
