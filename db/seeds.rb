# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


TypeCompany.find_or_initialize_by(name: 'telco') do |t|
	t.save!
	Company.find_or_initialize_by(name:"Claro", type_companies_id:t.id) do |c|
		c.save!
		Consumer.find_or_initialize_by(name:'zézinho da equina') do |consumer|
			consumer.save!
			Allotment.find_or_initialize_by(name: 'lote 1', consumers_id:consumer.id) do |allotment|
				allotment.save!
			end 
		end
	end
end
