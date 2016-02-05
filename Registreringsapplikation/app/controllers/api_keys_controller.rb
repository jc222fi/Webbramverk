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

  before_action :require_login
  def destroy
    @key = ApiKey.find(destroy_params[:id])

    if @key.user == current_user or current_user.is_admin?

      if @key.destroy
        flash[:notice] = "Api Key was deleted"
        redirect_to keys_path
      else
        flash[:notice] = "Api Key was not deleted"
      end
    else
      flash[:notice] = "Failed"
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
