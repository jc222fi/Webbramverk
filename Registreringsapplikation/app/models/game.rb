class Game < ActiveRecord::Base
  
  attr_accessor :href, :tag_href
  has_and_belongs_to_many :tags
  
  belongs_to :end_user
  belongs_to :location

  belongs_to :home_team, :class_name => 'Team'
  belongs_to :away_team, :class_name => 'Team'
  
end