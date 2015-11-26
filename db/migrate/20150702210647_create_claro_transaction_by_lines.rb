class CreateClaroTransactionByLines < ActiveRecord::Migration
  def change
    create_table :claro_transaction_by_lines do |t|
      t.string :name
      t.string :kind
      t.decimal :value, :decimal, :precision => 8, :scale => 2
      t.decimal :use_time, :decimal, :precision => 8, :scale => 2
      t.integer :allotment_id
      t.string :id_file

      t.timestamps null: false
    end
  end
end
