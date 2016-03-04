class Api::V1::TagsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :restrict_access
  respond_to :json

  def index
    respond_with Tag.all
  end

  def show
    respond_with Tag.find(params[:id])
  end

  def create
    tag = Tag.new(tag_params)

    if tag.save
      response.status = 201
      render :json => tag
    else
      response.status = 400
      render :json => {message: 'Tag already exists'}
    end
  end

  def update
    tag = Tag.find(update_destroy_params[:id])
    if tag.nil?
      response.status = 404
      render :json => {message: 'Tag was not found'}
    else
      tag.update(tag_params)
      response.status = 200
      render :json => tag
    end
  end

  def destroy
    tag = Tag.find(update_destroy_params[:id])

    if tag.destroy
      response.status = 200
      render :json => {message: 'Tag was deleted successfully'}
    else
      response.status = 400
      render :json => {message: 'Something went wrong, tag was not deleted'}
    end
  end
  
  private
  def tag_params
    params.permit(:name)
  end
  def update_destroy_params
    params.permit(:id)
  end
end
