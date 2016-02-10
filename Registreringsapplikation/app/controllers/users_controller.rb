class UsersController < ApplicationController
  def index

  end
  def show
    @users = User.all
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)

    if @user.save
      session[:userid] = @user.id
      redirect_to api_keys_path
    else
      render :action => "new"
    end
  end

  def login
    u = User.find_by_email(params[:email])
    if u && u.authenticate(params[:password])
      session[:userid] = u.id

      if u.is_admin?
        redirect_to allusers_path
      else
        redirect_to api_keys_path
      end
    else
      flash[:notice] = "Failed to login"
      redirect_to root_path
    end
  end

  def logout
    session[:userid] = nil
    redirect_to root_path, :notice => "Logged out"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
