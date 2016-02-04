class User < ActiveRecord::Base
  has_many :api_keys
  has_secure_password
end
