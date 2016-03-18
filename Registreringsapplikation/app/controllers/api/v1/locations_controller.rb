class Api::V1::LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :restrict_access
  respond_to :json

  def index
    if params[:search].present?
      locations = Location.near(params[:search], 50, :order => :distance)
    else
      
      if location_params[:offset] == nil || location_params[:limit] == nil
        response.status = 400
        render :json => {message: 'Please enter limit and offset parameters'}
      else
      
        locations = Location.order('created_at DESC').limit(location_params[:limit]).offset(location_params[:offset])
    
        locations.each do |location|
          location.href = api_v1_location_url(location.id)
        end
        
        response.status = 200
        render :json => locations, methods: [:href]
      end
    end
  end

  def show
    if params[:id].present?
      location = Location.find(params[:id])
      location.href = api_v1_location_url(location.id)
      response.status = 200
      render :json => {
          :locations => [location],
      }, methods: [:href]
    else
      response.status = 404
      render :json => {message: 'No locations found'}
    end
  end

  def create
    location = Location.new(location_params)

    if location.save
      location.href = api_v1_location_url(location.id)
      response.status = 201
      render :json => {
          :locations => [location],
      }, methods: [:href]
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
      location.update(location_params)
      location.href = api_v1_location_url(location.id)
      response.status = 200
      render :json => {
          :locations => [location],
      }, methods: [:href]
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
    params.permit(:address, :limit, :offset)
  end
  def update_destroy_params
    params.permit(:id)
  end
end
