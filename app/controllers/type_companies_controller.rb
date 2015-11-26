class TypeCompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_type_company, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_admin, only: :index

  def authorize_admin
    redirect_to :back, :status => 401 unless current_user.admin
    #redirects to previous page
  end

  # GET /type_companies
  # GET /type_companies.json
  def index
    @type_companies = TypeCompany.all
  end

  # GET /type_companies/1
  # GET /type_companies/1.json
  def show
  end

  # GET /type_companies/new
  def new
    @type_company = TypeCompany.new
  end

  # GET /type_companies/1/edit
  def edit
  end

  # POST /type_companies
  # POST /type_companies.json
  def create
    @type_company = TypeCompany.new(type_company_params)

    respond_to do |format|
      if @type_company.save
        format.html { redirect_to @type_company, notice: 'Type company was successfully created.' }
        format.json { render :show, status: :created, location: @type_company }
      else
        format.html { render :new }
        format.json { render json: @type_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_companies/1
  # PATCH/PUT /type_companies/1.json
  def update
    respond_to do |format|
      if @type_company.update(type_company_params)
        format.html { redirect_to @type_company, notice: 'Type company was successfully updated.' }
        format.json { render :show, status: :ok, location: @type_company }
      else
        format.html { render :edit }
        format.json { render json: @type_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_companies/1
  # DELETE /type_companies/1.json
  def destroy
    @type_company.destroy
    respond_to do |format|
      format.html { redirect_to type_companies_url, notice: 'Type company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_company
      @type_company = TypeCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_company_params
      params.require(:type_company).permit(:name)
    end
end
