class Api::V1::LocationsController < ApplicationController
  before_filter :restrict_access
  respond_to :json

  def index
    if params[:search].present?
      locations = Location.near(params[:search], 50, :order => :distance)
    else
      locations = Location.all
    end
    response.status = 200
    render :json => locations
  end

  def show
    if params[:id].present?
      locations = Location.find(params[:id])
      response.status = 200
      render :json => locations
    else
      response.status = 404
      render :json => {message: 'No locations found'}
    end
  end

  def create
    respond_with Location.create(params[:name])
  end

  def update
    respond_with Location.update(params[:id], params[:name])
  end

  def destroy
    respond_with Location.destroy(params[:id])
  end
end
