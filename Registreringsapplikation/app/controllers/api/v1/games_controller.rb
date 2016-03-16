class Api::V1::GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :restrict_access
  respond_to :json

  def index
    
    if game_params[:offset] == nil || game_params[:limit] == nil
      response.status = 400
      render :json => {message: 'Please enter limit and offset parameters'}
    else
      
      games = Game.order('created_at DESC').limit(game_params[:limit]).offset(game_params[:offset])
    
      games.each do |game|
        game.href = api_v1_games_url(game.id)
      end
  
      response.status = 200
      render :json => games, methods: [:href]
      
    end
    
  end
  
  def search_for
    #Do some pretty awesome stuff to search for games
    
      team_id = game_params[:team_id]

      if game_params[:offset] == nil || game_params[:limit] == nil
        response.status = 400
        render :json => {message: 'Please enter limit and offset parameters'}
      else
        
        limit = Integer(game_params[:limit])
        offset = Integer(game_params[:offset])
  
        if team_id.nil?
  
          response.status = 400
          render :json => { message: 'Please enter valid team id' }
  
          return
        else
  
          games = Game.where('home_team_id = ? OR away_team_id = ?', team_id, team_id)
          .order('created_at DESC').limit(limit).offset(offset)
          
          games.each do |game|
            game.href = api_v1_game_url(game.id)
          end
  
          response.status = 200
          render :json => {
              :games => games
          }, methods: [:href]
  
        end
        
      end

  end
  
  def add_tag
    
    game = Game.find(params[:id])
    tag = Tag.find(params[:tag_id])

    game.tags << tag

    game.href = api_v1_game_url(game.id)
    tag.href = api_v1_tag_url(tag.id)
    game.tag_href = games_tag_url(tag.id)

    response.status = 201
    render :json => {
        :games => [game],
        :tag => tag,
    }, methods: [:href, :tag_href]

  end
  
  def tag
    tag = Tag.find(game_params[:id])
    
    games = tag.games.order('created_at DESC').limit(game_params[:limit]).offset(game_params[:offset])
    
    games.each do |game|
        game.href = api_v1_games_url(game.id)
      end
  
      response.status = 200
      render :json => games, methods: [:href]
  end

  def show
    game = Game.find(params[:id])
    game.href = api_v1_game_url(game.id)
      response.status = 200
      render :json => {
          :games => [game],
      }, methods: [:href]
  end

  def create
    game = Game.new(
          home_score: game_params[:home_score],
          away_score: game_params[:away_score]
    )
    home_team = Team.find(game_params[:home_team_id])
    away_team = Team.find(game_params[:away_team_id])
    game.home_team = home_team
    game.away_team = away_team
    
    location = Location.find(game_params[:location_id])
    game.location = location
    
    end_user = EndUser.find(game_params[:end_user_id])
    game.end_user = end_user

    tag_name = game_params[:tag_name]
    
    if tag_name != nil
      
      tag = Tag.new(name: tag_name)
  
      if tag.save
        response.status = 201
        tag.href = api_v1_tag_url(tag.id)
        
      else
        response.status = 400
        render :json => {message: 'Tag already exists'}
        
        return
      end
      
    end

    if game.save
      game.href = api_v1_game_url(game.id)
      response.status = 201
      
      if tag_name != nil
        game.tag_href = api_v1_tag_url(tag.id)
        
        game.tags << tag
      end
      
      render :json => {
          :games => [game],
      }, methods: [:href, :tag_href]
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
      
      home_team = Team.find(game_params[:home_team_id])
      away_team = Team.find(game_params[:away_team_id])
      game.home_team = home_team
      game.away_team = away_team
      
      location = Location.find(game_params[:location_id])
      game.location = location
      
      end_user = EndUser.find(game_params[:end_user_id])
      game.end_user = end_user
      
      if game.save
      game.href = api_v1_game_url(game.id)
      response.status = 200
      render :json => {
          :games => [game],
      }, methods: [:href]
      else
        response.status = 400
        render :json => {message: 'Something went wrong, game was not updated'}
      end
    end
  end
  
  def remove_tag
    
    if Tag.exists?(:id => game_params[:tag_id]) && Game.exists?(:id => game_params[:id])
      
      game = Game.find(game_params[:id])
      tag = Tag.find(game_params[:tag_id])
      
      game.tags.delete(tag)

      response.status = 200
      render :nothing => true
    else
      response.status = 404
      render :json => {message: 'Game or tag doesn\'t exist, nothing was changed'}
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
    params.permit(:home_team_id, :away_team_id, :home_score, :away_score, :location_id, :end_user_id, :limit, :offset, :id, :tag_id, :team_id, :tag_name)
  end
  def update_destroy_params
    params.permit(:id)
  end
end
