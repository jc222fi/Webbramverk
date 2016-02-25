class Api::V1::TagsController < ApplicationController
  respond_to :json

  def index
    respond_with Tag.all
  end

  def show
    respond_with Tag.find(params[:id])
  end

  def create
    respond_with Tag.create(params[:tag])
  end

  def update
    respond_with Tag.update(params[:id], params[:tag])
  end

  def destroy
    respond_with Tag.destroy(params[:id])
  end
end
