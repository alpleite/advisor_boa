class VivoExtract < ActiveRecord::Base
  belongs_to :allotment
  belongs_to :pdf_file
end
