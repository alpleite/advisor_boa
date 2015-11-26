class AddUseTimeFromClaroTransactionByLineClaro < ActiveRecord::Migration
  def change
    add_column :claro_transaction_by_line_claros, :use_time, :decimal, :precision => 8, :scale => 2
  end
end
