class CreateVivoGroupWords < ActiveRecord::Migration
  def change
    create_table :vivo_group_words do |t|
      t.string :name
      t.string :key

      t.timestamps null: false
    end
  end
end
