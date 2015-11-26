class AddAllotmentToVivoTransationByLine < ActiveRecord::Migration
  def change
    add_reference :vivo_transation_by_lines, :allotment, index: true
    add_foreign_key :vivo_transation_by_lines, :allotments
  end
end
