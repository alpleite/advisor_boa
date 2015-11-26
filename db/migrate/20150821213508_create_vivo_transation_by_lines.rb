class CreateVivoTransationByLines < ActiveRecord::Migration
  def change
    create_table :vivo_transation_by_lines do |t|
      t.string :name
      t.decimal :amount, :precision => 8, :scale => 2

      t.timestamps null: false
    end
  end
end
