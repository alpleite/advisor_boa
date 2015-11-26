class CreateVivoExtracts < ActiveRecord::Migration
  def change
    create_table :vivo_extracts do |t|
      t.references :allotment, index: true
      t.references :pdf_file, index: true
      t.integer :line
      t.string :content

      t.timestamps null: false
    end
    add_foreign_key :vivo_extracts, :allotments
    add_foreign_key :vivo_extracts, :pdf_files
  end
end
