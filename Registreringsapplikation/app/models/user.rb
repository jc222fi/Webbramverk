class User < ActiveRecord::Base
  has_many :api_keys
  has_secure_password

  validates :name,
            :presence => {:message => "You need to include a name"},
            :length => {:minimum => 2, :message => "You need at least 2 letters in your name"}

  validates :email,
            :presence => {:message => "You need to include an e-mail"},
            :uniqueness => true,
            :length => {:minimum => 4, :message => "You need at least 4 letters in your e-mail"}

  validates :username,
            :presence => {:message => "You need to include a username"},
            :length => {:minimum => 2, :message => "You need at least 2 letters in your username"}

  validates :password,
            :presence => {:message => "You need a password"},
            :length => {:minimum => 6, :message => "Your password needs to contain at least 6 letters"}

  def is_admin?
    self.role.downcase == "administrator"
  end
end
