class ClaroTransactionByLineClarosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_claro_transaction_by_line_claro, only: [:show, :edit, :update, :destroy]

  before_filter :authorize_admin, only: :index

  def authorize_admin
    redirect_to :back, :status => 401 unless current_user.admin
    #redirects to previous page
  end

  # GET /claro_transaction_by_line_claros
  # GET /claro_transaction_by_line_claros.json
  def index
    @claro_transaction_by_line_claros = ClaroTransactionByLineClaro.all
  end

  # GET /claro_transaction_by_line_claros/1
  # GET /claro_transaction_by_line_claros/1.json
  def show
  end

  # GET /claro_transaction_by_line_claros/new
  def new
    @claro_transaction_by_line_claro = ClaroTransactionByLineClaro.new
  end

  # GET /claro_transaction_by_line_claros/1/edit
  def edit
  end

  # POST /claro_transaction_by_line_claros
  # POST /claro_transaction_by_line_claros.json
  def create
    @claro_transaction_by_line_claro = ClaroTransactionByLineClaro.new(claro_transaction_by_line_claro_params)

    respond_to do |format|
      if @claro_transaction_by_line_claro.save
        format.html { redirect_to @claro_transaction_by_line_claro, notice: 'Claro transaction by line claro was successfully created.' }
        format.json { render :show, status: :created, location: @claro_transaction_by_line_claro }
      else
        format.html { render :new }
        format.json { render json: @claro_transaction_by_line_claro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claro_transaction_by_line_claros/1
  # PATCH/PUT /claro_transaction_by_line_claros/1.json
  def update
    respond_to do |format|
      if @claro_transaction_by_line_claro.update(claro_transaction_by_line_claro_params)
        format.html { redirect_to @claro_transaction_by_line_claro, notice: 'Claro transaction by line claro was successfully updated.' }
        format.json { render :show, status: :ok, location: @claro_transaction_by_line_claro }
      else
        format.html { render :edit }
        format.json { render json: @claro_transaction_by_line_claro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claro_transaction_by_line_claros/1
  # DELETE /claro_transaction_by_line_claros/1.json
  def destroy
    @claro_transaction_by_line_claro.destroy
    respond_to do |format|
      format.html { redirect_to claro_transaction_by_line_claros_url, notice: 'Claro transaction by line claro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claro_transaction_by_line_claro
      @claro_transaction_by_line_claro = ClaroTransactionByLineClaro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claro_transaction_by_line_claro_params
      params.require(:claro_transaction_by_line_claro).permit(:name, :kind, :value, :allotment_id, :id_file)
    end
end
