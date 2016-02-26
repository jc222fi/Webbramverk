class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  helper_method :current_user, :check_end_user_auth

  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]
  end
  def require_login
    if current_user.nil? then
      redirect_to root_path
    end
  end

  #Helper for checking if end user is logged in
  def check_end_user_auth
    user = EndUser.try_get_logged_in_user(request.headers)

    if user.nil?
      response.status = 401
      redirect_to unauthorized_path

      return false
    end
    session['end_user'] = user
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(key: token)
    end
  end

=begin
  def check_api_key_auth(key_value)
    if ApiKey.find_by_key(key_value).nil?
      redirect_to unauthorized_key_path
      return false
    end
  end
=end
end
