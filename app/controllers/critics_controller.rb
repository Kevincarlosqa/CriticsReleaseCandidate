class CriticsController < ApplicationController
  before_action :set_critic, only: %i[ show edit update destroy ]

  # GET /critics
  def index
    @critics = Critic.all
  end

  # GET /critics/1
  def show
  end

  # GET /critics/new
  def new
    @critic = Critic.new
  end

  # GET /critics/1/edit
  def edit
  end

  # POST /critics
  def create
    @critic = Critic.new(critic_params)

    if @critic.save
      redirect_to @critic, notice: "Critic was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /critics/1
  def update
    if @critic.update(critic_params)
      redirect_to @critic, notice: "Critic was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /critics/1
  def destroy
    @critic.destroy
    redirect_to critics_url, notice: "Critic was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_critic
      @critic = Critic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def critic_params
      params.require(:critic).permit(:title, :body, :user_id)
    end
end
