class CreateClaroTransactionByLineClaros < ActiveRecord::Migration
  def change
    create_table :claro_transaction_by_line_claros do |t|
      t.string :name
      t.string :kind
      t.decimal :value, :precision => 8, :scale => 2
      t.integer :allotment_id
      t.string :id_file

      t.timestamps null: false
    end
  end
end
