class Api::V1::AwayTeamsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :restrict_access
  respond_to :json

  def index
    teams = AwayTeam.all
    
    response.status = 200
    render :json => teams
  end

  def show
    team = AwayTeam.find(params[:id])
    response.status = 200
    render :json => team
  end

  def create
    team = AwayTeam.new(team_params)

    if team.save
      response.status = 201
      render :json => team
    else
      response.status = 400
      render :json => {message: 'Team already exists'}
    end
  end

  def update
    team = AwayTeam.find(update_destroy_params[:id])
    if team.nil?
      response.status = 404
      render :json => {message: 'Team was not found'}
    else
      team.update(team_params)
      response.status = 200
      render :json => team
    end
  end

  def destroy
    team = AwayTeam.find(update_destroy_params[:id])

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
    params.permit(:name)
  end
  def update_destroy_params
    params.permit(:id)
  end
end