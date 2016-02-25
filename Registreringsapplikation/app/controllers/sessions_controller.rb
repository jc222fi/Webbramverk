class SessionsController < ApplicationController
  def index
  end

  def create
    auth = request.env["omniauth.auth"]

    user = EndUser.find_by_provider_and_uid(auth["provider"], auth["uid"]) || EndUser.create_with_omniauth(auth["provider"], auth["uid"])

    user.name = auth["info"]["name"] # could be updated (better check when new logins)
    user.token = auth["credentials"]["token"] # github provider token should not give out
    user.auth_token = SecureRandom.urlsafe_base64(nil, false) # generate a access_key for client to call the API
    user.token_expires = Time.now + 1.hour
    user.save

    # read back the session
    url = session[:client_call]
    session[:client_call] = nil
    redirect_to  "#{url}?auth_token=#{user.auth_token}&token_expires=#{Rack::Utils.escape(user.token_expires.to_s)}"
  end

  def destroy
    user = EndUser.try_get_logged_in_user(request.headers)
    if user.nil?
      response.status = 401
      render :nothing => true
    else
      user.expire
      response.status = 200
      render :nothing => true
    end
  end

  def authenticate
    session[:client_call] = params[:callback]
    redirect_to "/auth/github"
  end

  def unauthorized
    response.status = 401
    render :json => { :message => 'Not logged in' }
  end
  def unauthorized_key
    response.status = 401
    render :json => { :message => 'Wrong key' }
  end

  def test

    if check_end_user_auth && check_api_key_auth(params[:key])
      response.status = 200
      render :json => session['end_user']
    end

=begin
    user = EndUser.try_get_logged_in_user(request.headers)

    if user.nil?
      response.status = 401
      render :nothing => true
    else
      response.status = 200
      render :json => user
    end
=end

  end



=begin
  # This is just for testing stuff
  def test
    # check for the headers
    auth_token = request.headers["X-auth-token"] || nil
    user = nil
    unless auth_token.nil?
      # should test against expires-date also
      user = EndUser.find_by_auth_token(auth_token) || nil
    end

    if(user.nil?)
      response.status = 401
      render :nothing => true
    else
      response.status = 200
      render :json => user
    end
  end
=end
end
