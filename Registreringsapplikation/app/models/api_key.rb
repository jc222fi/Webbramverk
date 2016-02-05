class ApiKey < ActiveRecord::Base
  belongs_to :user
  before_create :generate_key

  private
  def generate_key
    begin self.key = SecureRandom.hex(24)
    end while self.class.exists?(key: key)
  end
end
