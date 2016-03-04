class Api::V1::GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
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
    game = Game.new(
          home_score: game_params[:home_score],
          away_score: game_params[:away_score]
    )
    home_team = HomeTeam.find(game_params[:home_team_id])
    away_team = AwayTeam.find(game_params[:away_team_id])
    game.home_team = home_team
    game.away_team = away_team
    
    location = Location.find(game_params[:location_id])
    game.location = location
    
    end_user = EndUser.find(game_params[:end_user_id])
    game.end_user = end_user

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
      home_score = game_params[:home_score]
      away_score = game_params[:away_score]
      game.home_score = home_score
      game.away_score = away_score
      
      home_team = HomeTeam.find(game_params[:home_team_id])
      away_team = AwayTeam.find(game_params[:away_team_id])
      game.home_team = home_team
      game.away_team = away_team
      
      location = Location.find(game_params[:location_id])
      game.location = location
      
      end_user = EndUser.find(game_params[:end_user_id])
      game.end_user = end_user
      
      if game.save
      response.status = 200
      render :json => game
      else
        response.status = 400
        render :json => {message: 'Something went wrong, game was not updated'}
      end
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
    params.permit(:home_team_id, :away_team_id, :home_score, :away_score, :location_id, :end_user_id)
  end
  def update_destroy_params
    params.permit(:id)
  end
end
