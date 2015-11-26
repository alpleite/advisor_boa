class ConsumersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_consumer, only: [:show, :edit, :update]

  before_filter :authorize_admin, only: :index

  def authorize_admin
    redirect_to :back, :status => 401 unless current_user.admin
    #redirects to previous page
  end

  # GET /consumers
  # GET /consumers.json
  def index
    @consumers = Consumer.all
    #263957 - Advisor Blue (Substituted: #2f4050-Menu and 18a689-Green login)
    #1F2F4A - Advisor Blue Alternate (Sub: #293846 )
    #999999 - Light Gray
    #555555 - Dark Gray
    #2A88A9 - Blue Bright
    #74A8B6 - Blue Pastel
    #E51950 - Pink
    #89C53F - Green*/

   
  

  end

  # GET /consumers/1
  # GET /consumers/1.json
  def show
     @data_line = {
              labels: ["January", "February", "March", "April", "May", "June", "July"],
              datasets: [
              {
                label: "My First dataset", 
                fillColor: "rgba(220,220,220,0.2)",strokeColor: "rgba(220,220,220,1)",
                pointColor: "rgba(220,220,220,1)", pointStrokeColor: "#fff", pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [65, 59, 80, 81, 56, 55, 40]
              },
              {
                label: "My Second dataset",
                fillColor: "rgba(44,68,106,0.2)", strokeColor: "rgba(44,68,106,1)",
                pointColor: "rgba(44,68,106,0,1)", pointStrokeColor: "#fff",
                pointHighlightFill: "#fff", pointHighlightStroke: "rgba(151,187,205,1)",
                data: [28, 48, 40, 19, 86, 27, 90]
              }
              ]
            }

  @data_pie = [
            {   value: 300,
                color:"#2C446A",
                highlight: "#999999",
                label: "Interurbanos"
            },

            {
                value: 80,
                color: "#E51950",
                highlight: "#999999",
                label: "Messages"
            },
            {
                value: 50,
                color: "#74A8B6",
                highlight: "#999999",
                label: "Others"
            }
            ]

  @data_bar = {
              labels: ["Outubro",],
              datasets: [
              {
                label: "2014", 
                fillColor: "rgba(200,200,200,0.5)",
                strokeColor: "rgba(180,180,180,0.8)",
                highlightFill: "rgba(180,180,180,0.75)",
                highlightStroke: "rgba(160,160,160,1)",
                data: [65]
              },
              {
                label: "2015",
                fillColor: "rgba(151,187,205,0.5)",
                strokeColor: "rgba(151,187,205,0.8)",
                highlightFill: "rgba(151,187,205,0.75)",
                highlightStroke: "rgba(151,187,205,1)",
                data: [28]
              }
              ]
            }

  @options_line = {
            height: '162',
            :generateLegend => true,
            :legendTemplate => "<ul class=\"list-group clear-list m-t-none m-b-none\" style=\"display:inline\"><% for (var i=0; i<datasets.length; i++){%><li class=\"list-group-item fist-item  m-l-sm\"><span class=\"label\" style=\"background-color:<%=datasets[i].strokeColor%>\">&nbsp;&nbsp;</span>&nbsp;<%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>",
            
  }

  @options_pie = {
            height: '250',
            # :width => '200px',
            # :height => '150px',
            # //Boolean - Whether we should show a stroke on each segment
            :segmentShowStroke => true,
            # //String - The colour of each segment stroke
            :segmentStrokeColor => "#fff",
            # //Number - The width of each segment stroke
            :segmentStrokeWidth => 2,
            # //Number - The percentage of the chart that we cut out of the middle
            :percentageInnerCutout => 50, #// This is 0 for Pie charts
            # //Number - Amount of animation steps
            :animationSteps => 100,
            # //String - Animation easing effect
            :animationEasing => "easeOutBounce",
            # //Boolean - Whether we animate the rotation of the Doughnut
            :animateRotate => true,
            # //Boolean - Whether we animate scaling the Doughnut from the centre
            :animateScale => false,
            :generateLegend => true,
            # :legendTemplate => "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><div class=\"legend-marker\" style=\"background-color:<%=segments[i].fillColor%>\"></div><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",
            :legendTemplate => "<ul class=\"list-group clear-list m-t m-b-none\"><% for (var i=0; i<segments.length; i++){%><li class=\"list-group-item fist-item m-l-s\"><span class=\"label\" style=\"background-color:<%=segments[i].fillColor%>\">&nbsp;</span>&nbsp;&nbsp;<%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>",

        }
  @options_bar = {
            height: '100',
  }

  # //String - A legend template
  end

  # GET /consumers/new
  def new
    @consumer = Consumer.new
  end

  # GET /consumers/1/edit
  def edit
  end

  # POST /consumers
  # POST /consumers.json
  def create
    @consumer = Consumer.new(consumer_params)

    respond_to do |format|
      if @consumer.save
        format.html { redirect_to @consumer, notice: 'Consumer was successfully created.' }
        format.json { render :show, status: :created, location: @consumer }
      else
        format.html { render :new }
        format.json { render json: @consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consumers/1
  # PATCH/PUT /consumers/1.json
  def update
    respond_to do |format|
      if @consumer.update(consumer_params)
        format.html { redirect_to @consumer, notice: 'Consumer was successfully updated.' }
        format.json { render :show, status: :ok, location: @consumer }
      else
        format.html { render :edit }
        format.json { render json: @consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumer
      @consumer = Consumer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumer_params
      params.require(:consumer).permit(:name, :phone)
    end
end
