class Company < ActiveRecord::Base
	

	validates :name, :presence => true
	validates :type_companies_id,  :presence => true
	belongs_to :type_companies, class_name: TypeCompany
	
end
