class DataPdfsController < ApplicationController
  #before_action :set_data_pdf, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  before_filter :authorize_admin, only: :index

  def authorize_admin
    redirect_to :back, :status => 401 unless current_user.admin
    #redirects to previous page
  end
  # GET /data_pdfs
  # GET /data_pdfs.json
  def index

    @lote = Allotment.find_by_token(params[:id])
    @files = PdfFile.where("allotments_id = ?", @lote.id)
    #binding.pry
    @company_id = PdfFile.where(pdf_file_id:params["pdf_file_id"]).first.company_id if params["pdf_file_id"]


    #binding.pry

    @header_manager_claro = []
    @manager_by_line = []
    @claro_transaction_by_line = []
    @claroTransactionByLineClaro = []


    @header_manager_vivo = []


    #binding.pry

    if  params[:pdf_file_id] and PdfFile.where(pdf_file_id:params["pdf_file_id"]).first.company_id == 1
      #binding.pry
      @header_manager_claro         = HeaderManagerClaro.where("allotment_id = ? AND id_file = ? ",  @lote.id,  params[:pdf_file_id] ).order("id ASC")
      @manager_by_line              = ClaroManagerByLine.where("allotment_id = ? AND id_file = ? ",  @lote.id,  params[:pdf_file_id] ).order("id ASC")
      @claro_transaction_by_line    = ClaroTransactionByLine.where("allotment_id = ? AND id_file = ? ",  @lote.id,  params[:pdf_file_id] ).order("id ASC")
      @claroTransactionByLineClaro  = ClaroTransactionByLineClaro.where("allotment_id = ? AND id_file = ? ",  @lote.id,  params[:pdf_file_id] ).order("id ASC")
      
    elsif params[:pdf_file_id] and PdfFile.where(pdf_file_id:params["pdf_file_id"]).first.company_id == 2
      pdf_file_id = PdfFile.where("pdf_file_id = ?", params[:pdf_file_id]).first.id
      @header_manager_vivo = VivoHeaderManager.where("allotment_id = ? AND pdf_file_id = ? ",  @lote.id,  pdf_file_id ).order("id ASC")
    end

    respond_to do |format|
      format.html
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_pdf
      #@data_pdf = DataPdf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_pdf_params
      #params[:data_pdf]
    end
end
