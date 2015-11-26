class CreateTypeCompanies < ActiveRecord::Migration
  def change
    create_table :type_companies do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
