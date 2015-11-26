class CreateClaroExtracts < ActiveRecord::Migration
  def change
    create_table :claro_extracts do |t|
      t.integer :line
      t.string :content
      t.references :allotment, index: true

      t.timestamps null: false
    end
    #add_foreign_key :claro_extracts, :allotment, column: :allotments_id
  end
end
