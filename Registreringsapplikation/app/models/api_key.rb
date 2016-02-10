class ApiKey < ActiveRecord::Base
  belongs_to :user
  before_create :generate_key
  validates :app_name,
            :length => {:minimum => 2, :message => ", you need at least 2 letters in your app name"}

  private
  def generate_key
    begin self.key = SecureRandom.hex(24)
    end while self.class.exists?(key: key)
  end
end
