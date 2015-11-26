class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.references :type_companies, index: true

      t.timestamps null: false
    end
    add_foreign_key :companies, :type_companies, column: :type_companies_id
  end
end
