class AddTokenFromAllotments < ActiveRecord::Migration
  def change
    add_column :allotments, :token, :string
  end
end
