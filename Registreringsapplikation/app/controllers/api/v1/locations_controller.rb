class Api::V1::LocationsController < ApplicationController
  respond_to :json

  def index
    locations = Location.all

    response.status = 200
    render :json => locations
  end

  def show
    respond_with Location.find(params[:id])
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
