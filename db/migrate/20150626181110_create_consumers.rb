class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :name
      t.string :phone

      t.timestamps null: false
    end
  end
end
