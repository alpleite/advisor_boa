class CreateClaroManagerByLines < ActiveRecord::Migration
  def change
    create_table :claro_manager_by_lines do |t|
      t.string :kind
      t.string :item
      t.decimal :value, :precision => 8, :scale => 2
      t.integer :allotment_id
      t.string :id_file

      t.timestamps null: false
    end
  end
end
