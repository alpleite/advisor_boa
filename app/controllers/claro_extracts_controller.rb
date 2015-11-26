class ClaroExtractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_claro_extract, only: [:show, :edit, :update, :destroy]

  before_filter :authorize_admin, only: :index

  def authorize_admin
    redirect_to :back, :status => 401 unless current_user.admin
    #redirects to previous page
  end

  # GET /claro_extracts
  # GET /claro_extracts.json
  def index
    #binding.pry
    @claro_extracts = ClaroExtract.all
  end

  # GET /claro_extracts/1
  # GET /claro_extracts/1.json
  def show
  end

  # GET /claro_extracts/new
  def new
    @claro_extract = ClaroExtract.new
  end

  # GET /claro_extracts/1/edit
  def edit
  end

  # POST /claro_extracts
  # POST /claro_extracts.json
  def create
    @claro_extract = ClaroExtract.new(claro_extract_params)

    respond_to do |format|
      if @claro_extract.save
        format.html { redirect_to @claro_extract, notice: 'Claro extract was successfully created.' }
        format.json { render :show, status: :created, location: @claro_extract }
      else
        format.html { render :new }
        format.json { render json: @claro_extract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claro_extracts/1
  # PATCH/PUT /claro_extracts/1.json
  def update
    respond_to do |format|
      if @claro_extract.update(claro_extract_params)
        format.html { redirect_to @claro_extract, notice: 'Claro extract was successfully updated.' }
        format.json { render :show, status: :ok, location: @claro_extract }
      else
        format.html { render :edit }
        format.json { render json: @claro_extract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claro_extracts/1
  # DELETE /claro_extracts/1.json
  def destroy
    @claro_extract.destroy
    respond_to do |format|
      format.html { redirect_to claro_extracts_url, notice: 'Claro extract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claro_extract
      @claro_extract = ClaroExtract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claro_extract_params
      params.require(:claro_extract).permit(:line, :content, :allotment_id)
    end
end
