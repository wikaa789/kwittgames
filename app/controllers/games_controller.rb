class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]




  # GET /games
  # GET /games.json
  def index
   @games = Game.all.reverse_order
   
   if params[:search]
      @games = Game.search(params[:search]).order("created_at DESC")
    else
      @games = Game.all.order("created_at DESC")
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    game = Game.find(params[:id])
    
    @comments = game.comments.reverse_order
    
    @ratings = game.ratings
    
    @sum_ratings = 0
    
    for rating in @ratings
      @sum_ratings = @sum_ratings + rating.value
    end
    
    @average_rating = (@sum_ratings.to_f / @ratings.length).round(1)
  end

  # GET /games/new
  def new
    @game = current_user.games.build
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = current_user.games.create(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :description, :creator, :rating, :image, :url, :user_id)
    end
end
