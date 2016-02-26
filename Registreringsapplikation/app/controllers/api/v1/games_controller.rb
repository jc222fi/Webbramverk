class Api::V1::GamesController < ApplicationController
  before_filter :restrict_access
  respond_to :json

  def index
    games = Game.all

=begin
    games.each do |game|
      game.href = api_v1_location_url(location.id)
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
    respond_with Game.create(params[:game])
  end

  def update
    respond_with Game.update(params[:id], params[:game])
  end

  def destroy
    respond_with Game.destroy(params[:id])
  end
end
