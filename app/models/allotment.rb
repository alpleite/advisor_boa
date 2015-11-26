class Allotment < ActiveRecord::Base
   
   belongs_to :consumers, class_name: Consumer

   validates :name, :presence => true

   enum status: [:in_progress, :completed, :invoiced, :newer]

   def consumer_name
   		id = self.id
   		#binding.pry
   		return "#{Consumer.find_by_id(self.consumers_id).name}"
   end

end
