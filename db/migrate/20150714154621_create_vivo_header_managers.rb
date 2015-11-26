class CreateVivoHeaderManagers < ActiveRecord::Migration
  def change
    create_table :vivo_header_managers do |t|
      t.references :allotment, index: true
      t.references :pdf_file, index: true
      t.string :item
      t.integer :number_of_lines
      t.integer :amount_of_plans
      t.decimal :contracted_amount, :precision => 8, :scale => 2
      t.string :contracted_service
      t.string :service_used

      t.timestamps null: false
    end
    add_foreign_key :vivo_header_managers, :allotments
    add_foreign_key :vivo_header_managers, :pdf_files
  end
end
