class Api::V1::TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :restrict_access
  respond_to :json

  def index
    
    if team_params[:offset] == nil || team_params[:limit] == nil
      response.status = 400
      render :json => {message: 'Please enter limit and offset parameters'}
      
    else
      
      teams = Team.order('created_at DESC').limit(team_params[:limit]).offset(team_params[:offset])
    
      teams.each do |team|
        team.href = api_v1_team_url(team.id)
      end
      response.status = 200
      render :json => teams, methods: [:href]
      
    end
  end

  def show
    team = Team.find(params[:id])
    team.href = api_v1_team_url(team.id)
      response.status = 200
      render :json => {
          :teams => [team],
      }, methods: [:href]
  end

  def create
    team = Team.new(team_params)

    if team.save
      response.status = 201
      team.href = api_v1_team_url(team.id)
      render :json => {
          :teams => [team],
      }, methods: [:href]
    else
      response.status = 400
      render :json => {message: 'Team already exists'}
    end
  end

  def update
    team = Team.find(update_destroy_params[:id])
    if team.nil?
      response.status = 404
      render :json => {message: 'Team was not found'}
    else
      team.update(team_params)
      response.status = 200
      team.href = api_v1_team_url(team.id)
      render :json => {
          :teams => [team],
      }, methods: [:href]
    end
  end

  def destroy
    team = Team.find(update_destroy_params[:id])

    if team.destroy
      response.status = 200
      render :json => {message: 'Team was deleted successfully'}
    else
      response.status = 400
      render :json => {message: 'Something went wrong, team was not deleted'}
    end
  end
  
  private
  def team_params
    params.permit(:name, :limit, :offset)
  end
  def update_destroy_params
    params.permit(:id)
  end
end
