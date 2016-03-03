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
    location = Location.new(location_params)

    if location.save
      response.status = 201
      render :json => location
    else
      response.status = 400
      render :json => {message: 'Something went wrong, location was not created'}
    end
  end

  def update
    location = Location.find(update_destroy_params[:id])
    if location.nil?
      response.status = 404
      render :json => {message: 'Location was not found'}
    else
      response.status = 200
      render :json => location
    end
  end

  def destroy
    location = Location.find(update_destroy_params[:id])

    if location.destroy
      response.status = 200
      render :json => {message: 'Location was deleted successfully'}
    else
      response.status = 400
      render :json => {message: 'Something went wrong, location was not deleted'}
    end
  end

  private
  def location_params
    params.require(:location).permit(:address)
  end
  def update_destroy_params
    params.permit(:id)
  end
end
