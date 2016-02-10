class User < ActiveRecord::Base
  has_many :api_keys
  has_secure_password

  validates :email,
            :uniqueness => true,
            :length => {:minimum => 4, :message => ", you need at least 4 letters in your e-mail"}
  validates_format_of :email,
                      :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password,
            :length => {:minimum => 6, :message => ", your password needs to contain at least 6 letters"}

  def is_admin?
    self.role.downcase == "administrator"
  end
end
