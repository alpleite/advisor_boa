class AddFieldsFromClaroTransactionByLines < ActiveRecord::Migration
  def change
    add_column :claro_transaction_by_lines, :valor_total, :decimal, :precision => 8, :scale => 2
    add_column :claro_transaction_by_lines, :valor_cobrado, :decimal, :precision => 8, :scale => 2
  end
end
