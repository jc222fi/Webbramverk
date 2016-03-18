class Location < ActiveRecord::Base
  attr_accessor :href
  has_many :games
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
