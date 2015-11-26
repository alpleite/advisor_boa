class CreateHeaderManagerClaros < ActiveRecord::Migration
  def change
    create_table :header_manager_claros do |t|
      t.string :name
      t.string :item
      t.string :tipo
      t.decimal :value, :decimal, :precision => 8, :scale => 2
      t.integer :allotment_id
      t.string :id_file

      t.timestamps null: false
    end
  end
end
