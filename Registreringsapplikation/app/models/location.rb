class Location < ActiveRecord::Base
  has_many :games
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
