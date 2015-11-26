class AddIdFileFromClaroExtracts < ActiveRecord::Migration
  def change
    add_column :claro_extracts, :id_file, :string
  end
end
