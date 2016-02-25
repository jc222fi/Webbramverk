class EndUser < ActiveRecord::Base
  has_many :games
  def self.create_with_omniauth(provider, uid)
    create! do |user|
      user.provider = provider
      user.uid = uid
    end
  end

  def expire
    self.token_expires = Time.now - 1.hour
    self.save
  end

  def did_login_expire?
    self.token_expires < Time.now
  end

  def self.try_get_logged_in_user(headers)
    auth_token = headers["X-auth-token"] || nil
    user = nil
    unless auth_token.nil?
      user = EndUser.find_by_auth_token(auth_token) || nil
    end
    unless user.nil? || user.did_login_expire?
      return user
    end
    return nil
  end
end
