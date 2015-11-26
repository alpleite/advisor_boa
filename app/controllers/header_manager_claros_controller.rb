class HeaderManagerClarosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_header_manager_claro, only: [:show, :edit, :update, :destroy]

  before_filter :authorize_admin, only: :index

  def authorize_admin
    redirect_to :back, :status => 401 unless current_user.admin
    #redirects to previous page
  end

  # GET /header_manager_claros
  # GET /header_manager_claros.json
  def index
    @header_manager_claros = HeaderManagerClaro.all
  end

  # GET /header_manager_claros/1
  # GET /header_manager_claros/1.json
  def show
  end

  # GET /header_manager_claros/new
  def new
    @header_manager_claro = HeaderManagerClaro.new
  end

  # GET /header_manager_claros/1/edit
  def edit
  end

  # POST /header_manager_claros
  # POST /header_manager_claros.json
  def create
    @header_manager_claro = HeaderManagerClaro.new(header_manager_claro_params)

    respond_to do |format|
      if @header_manager_claro.save
        format.html { redirect_to @header_manager_claro, notice: 'Header manager claro was successfully created.' }
        format.json { render :show, status: :created, location: @header_manager_claro }
      else
        format.html { render :new }
        format.json { render json: @header_manager_claro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /header_manager_claros/1
  # PATCH/PUT /header_manager_claros/1.json
  def update
    respond_to do |format|
      if @header_manager_claro.update(header_manager_claro_params)
        format.html { redirect_to @header_manager_claro, notice: 'Header manager claro was successfully updated.' }
        format.json { render :show, status: :ok, location: @header_manager_claro }
      else
        format.html { render :edit }
        format.json { render json: @header_manager_claro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /header_manager_claros/1
  # DELETE /header_manager_claros/1.json
  def destroy
    @header_manager_claro.destroy
    respond_to do |format|
      format.html { redirect_to header_manager_claros_url, notice: 'Header manager claro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_header_manager_claro
      @header_manager_claro = HeaderManagerClaro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def header_manager_claro_params
      params.require(:header_manager_claro).permit(:name, :item, :tipo, :value, :allotment_id, :id_file)
    end
end
