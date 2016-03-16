class Api::V1::TagsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :restrict_access
  respond_to :json

  def index
    
    if tag_params[:offset] == nil || tag_params[:limit] == nil
      response.status = 400
      render :json => {message: 'Please enter limit and offset parameters'}
    else
      
      tags = Tag.order('created_at DESC').limit(tag_params[:limit]).offset(tag_params[:offset])
    
      tags.each do |tag|
        tag.href = api_v1_tag_url(tag.id)
      end
      response.status = 200
      render :json => tags, methods: [:href]
      
    end
    
  end

  def show
    tag Tag.find(params[:id])
    tag.href = api_v1_tag_url(tag.id)
    response.status = 200
    render :json => {
        :tags => [tag],
    }, methods: [:href]
    
  end

  def create
    tag = Tag.new(tag_params)

    if tag.save
      response.status = 201
      tag.href = api_v1_tag_url(tag.id)
      render :json => {
          :tags => [tag],
      }, methods: [:href]
      
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
      tag.href = api_v1_tag_url(tag.id)
      render :json => {
          :tags => [tag],
      }, methods: [:href]
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
    params.permit(:name, :limit, :offset)
  end
  def update_destroy_params
    params.permit(:id)
  end
end
