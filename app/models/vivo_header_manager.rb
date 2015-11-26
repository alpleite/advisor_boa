class VivoHeaderManager < ActiveRecord::Base
  belongs_to :allotment
  belongs_to :pdf_file

  #enum type_enclosed: [:min, :gb, :regular, :mb]


end
