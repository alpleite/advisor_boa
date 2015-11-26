class RemoveDecimalFromClaroTransactionByLine < ActiveRecord::Migration
  def change
    remove_column :claro_transaction_by_lines, :decimal, :decimal
  end
end
