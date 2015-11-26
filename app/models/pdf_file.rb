class PdfFile < ActiveRecord::Base
	
	attachment :pdf_file, extension: "pdf"
	
	validates :pdf_file, presence: true
	validates :allotments_id, presence: true
	validates :company_id, presence: true


	def lote_name
		return "#{Allotment.find_by_id(self.allotments_id).name}"
	end

end
