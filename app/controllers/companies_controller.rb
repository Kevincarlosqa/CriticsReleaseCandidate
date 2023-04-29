class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  # GET /companies
  def index
    @companies = Company.all
  end

  # GET /companies/1
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  def create
    game = Game.find(params[:game_id])
    if params[:company] == "developer"
      company = Company.find_by(name: params[:name])
      game.involved_companies.create(company_id: company.id, developer: true, publisher: false)
    elsif params[:company] == "publisher"
      company = Company.find_by(name: params[:name])
      game.involved_companies.create(company_id: company.id, developer: false, publisher: true)
    end
    redirect_to game_path(:game_id)
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      redirect_to @company, notice: "Company was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy
    redirect_to game_path(:game_id), notice: "Company was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :description, :start_date, :country, :cover)
    end
end
