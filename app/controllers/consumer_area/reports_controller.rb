class ConsumerArea::ReportsController < ApplicationController
	def index

		#binding.pry

		#p = PdfFile.last

		#@claroTransactionByLine  = ClaroTransactionByLine.where(:id_file=>p.id).order("id ASC").firts
    	
    	@data_bar = {
              labels: ["Outubro"],
              datasets: [
              {
                label: "2014", 
                fillColor: "rgba(200,200,200,0.5)",
                strokeColor: "rgba(180,180,180,0.8)",
                highlightFill: "rgba(180,180,180,0.75)",
                highlightStroke: "rgba(160,160,160,1)",
                data: [64,]
              },
              {
                label: "2015",
                fillColor: "rgba(151,187,205,0.5)",
                strokeColor: "rgba(151,187,205,0.8)",
                highlightFill: "rgba(151,187,205,0.75)",
                highlightStroke: "rgba(151,187,205,1)",
                data: [134,]
              }
              ]
            }


         @options_bar = {
            height: '100',
  		}


  	end
end
