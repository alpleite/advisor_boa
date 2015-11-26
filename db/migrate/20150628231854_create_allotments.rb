class CreateAllotments < ActiveRecord::Migration
  def change
    create_table :allotments do |t|
      t.string :name
      t.references :consumers, index: true
      t.integer :status

      t.timestamps null: false
    end
    add_foreign_key :allotments, :consumers , column: :consumers_id
  end
end
