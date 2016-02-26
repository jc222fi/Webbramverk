class Api::V1::GamesController < ApplicationController
  before_filter :restrict_access
  respond_to :json

  def index
    games = Game.all

=begin
    games.each do |game|
      game.href = api_v1_locations_url(location.id)
    end
=end

    response.status = 200
    render :json => games, methods: [:href]
  end

  def show
    game = Game.find(params[:id])
    response.status = 200
    render :json => game
  end

  def create
    game = Game.new(game_params)

    if game.save
      response.status = 201
      render :json => game
    else
      response.status = 400
      render :json => {message: 'Something went wrong, game was not created'}
    end
  end

  def update
    game = Game.find(update_destroy_params[:id])
    if game.nil?
      response.status = 404
      render :json => {message: 'Game was not found'}
    else
      response.status = 200
      render :json => game
    end
  end

  def destroy
    game = Game.find(update_destroy_params[:id])

    if game.destroy
      response.status = 200
      render :json => {message: 'Game was deleted successfully'}
    else
      response.status = 400
      render :json => {message: 'Something went wrong, game was not deleted'}
    end
  end

  private
  def game_params
    params.require(:game).permit(:home_score, :away_score)
  end
  def update_destroy_params
    params.permit(:id)
  end
end
