class ClaroExtract < ActiveRecord::Base
 

  belongs_to :allotments, class_name: Allotment

  validates :line, :presence => true
  #validates :content, :presence => true
  validates :allotment_id, :presence => true
end
