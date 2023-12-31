class GenresController < ApplicationController
  before_action :set_genre, only: %i[ show edit update destroy ]

  # GET /genres
  def index
    @genres = Genre.all
  end

  # GET /genres/1
  def show
  end

  # GET /genres/new
  def new
    @genre = Genre.new
  end

  # GET /genres/1/edit
  def edit
  end

  # POST /genres
  def create
    game = Game.find(params[:game_id])
    genre = Genre.find_by(name: params[:name])
    game.genres.push(genre)
    redirect_to game_path(:game_id)
  end

  # PATCH/PUT /genres/1
  def update
    if @genre.update(genre_params)
      redirect_to @genre, notice: "Genre was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /genres/1
  def destroy
    @genre.destroy
    redirect_to game_path(:game_id), notice: "Genre was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def genre_params
      params.require(:genre).permit(:name)
    end
end
