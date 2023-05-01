class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
    @game = Game.find(params[:id])
 
  end

  # GET /games/new
  def new
    @game = Game.new
    authorize @game
  end

  # GET /games/1/edit
  def edit
    authorize @game
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game, notice: "Game was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: "Game was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    authorize @game
    redirect_to games_url, notice: "Game was successfully destroyed."
  end

  private

    # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :parent_id, :image)
  end
end
