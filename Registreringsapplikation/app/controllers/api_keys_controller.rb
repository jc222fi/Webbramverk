class ApiKeysController < ApplicationController
  before_action :require_login
  def show
    @keys = ApiKey.find_by_user_id(current_user.id)
  end

  before_action :require_login
  def new
    @key = ApiKey.new
  end

  before_action :require_login
  def create
    @key = ApiKey.new(key_params)
    @key.user = current_user

    if @key.save
      redirect_to keys_path
    else
      render :action => "new"
    end
  end

  private

  def key_params
    params.require(:api_key).permit(:app_name)
  end
  def destroy_params
    params.permit(:id)
  end
end
