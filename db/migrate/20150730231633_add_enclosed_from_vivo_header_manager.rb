class AddEnclosedFromVivoHeaderManager < ActiveRecord::Migration
  def change
    add_column :vivo_header_managers, :enclosed, :integer
    add_column :vivo_header_managers, :type_enclosed, :integer
    add_column :vivo_header_managers, :utilized, :integer
    add_column :vivo_header_managers, :type_utilized, :integer
  end
end
