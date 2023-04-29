class PlatformsController < ApplicationController
  before_action :set_platform, only: %i[ show edit update destroy ]

  # GET /platforms
  def index
    @platforms = Platform.all
  end

  # GET /platforms/1
  def show
  end

  # GET /platforms/new
  def new
    @platform = Platform.new
  end

  # GET /platforms/1/edit
  def edit
  end

  # POST /platforms
  def create
    game = Game.find(params[:game_id])
    platform = Platform.find_by(name: params[:name])
    game.platforms.push(platform)
    redirect_to game_path(:game_id)
  end

  # PATCH/PUT /platforms/1
  def update
    if @platform.update(platform_params)
      redirect_to @platform, notice: "Platform was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /platforms/1
  def destroy
    @platform.destroy
    redirect_to game_path(:game_id), notice: "Platform was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_platform
      @platform = Platform.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def platform_params
      params.require(:platform).permit(:name, :category)
    end
end
