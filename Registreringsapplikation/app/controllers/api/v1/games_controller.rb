class Api::V1::GamesController < ApplicationController
  #before_filter :restrict_access
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
    respond_with Game.find(params[:id])
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


  private
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(key: token)
    end
  end
end
