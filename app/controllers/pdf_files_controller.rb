class PdfFilesController < ApplicationController
  before_action :set_pdf_file, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  before_filter :authorize_admin, only: :index

  def authorize_admin
    redirect_to :back, :status => 401 unless current_user.admin
    #redirects to previous page
  end

  # GET /pdf_files
  # GET /pdf_files.json
  def index
    #binding.pry
    @lote = Allotment.find_by_token "#{params["id"]}"
    @pdf_files = PdfFile.where("allotments_id = ?", @lote.id)

  end

  # GET /pdf_files/1
  # GET /pdf_files/1.json
  def show
  end

  # GET /pdf_files/new
  def new
    @pdf_file = PdfFile.new
    @token = params["id"]
  end

  # GET /pdf_files/1/edit
  def edit
  end

  # POST /pdf_files
  # POST /pdf_files.json
  def create
    
    @token = params["pdf_file"]["allotments_id"]

    @pdf_file = PdfFile.new(pdf_file_params)
    
    @pdf_file.allotments_id = Allotment.find_by_token("#{pdf_file_params["allotments_id"]}").id

    respond_to do |format|

      if @pdf_file.save

        #binding.pry
        
        @pdf_file.name = pdf_file_params["pdf_file"].original_filename
        
        @pdf_file.save!

        format.html { redirect_to pdf_files_path(:id=>"#{pdf_file_params["allotments_id"]}"), notice: 'Pdf file was successfully created.' }
        format.json { render :show, status: :created, location: @pdf_file }
      else
        format.html {render :new}
        format.json { render json: @pdf_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
    send_file Refile.attachment_url(@pdf_file, :pdf_file), type: @pdf_file.pdf_file_content_type, disposition: :attachment
  end

  # PATCH/PUT /pdf_files/1
  # PATCH/PUT /pdf_files/1.json
  def update
    respond_to do |format|
      if @pdf_file.update(pdf_file_params)
        format.html { redirect_to @pdf_file, notice: 'Pdf file was successfully updated.' }
        format.json { render :show, status: :ok, location: @pdf_file }
      else
        format.html { render :edit }
        format.json { render json: @pdf_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pdf_files/1
  # DELETE /pdf_files/1.json
  def destroy
    @pdf_file.destroy
    respond_to do |format|
      format.html { redirect_to pdf_files_url, notice: 'Pdf file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pdf_file
      @pdf_file = PdfFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pdf_file_params
      params.require(:pdf_file).permit(:name, :path, :type, :allotments_id, :pdf_file, :company_id)
    end
end
