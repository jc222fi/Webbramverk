class Team < ActiveRecord::Base
  
  attr_accessor :href
  
  #belongs_to :away_team
  #belongs_to :home_team
  
  has_one :home_team, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_one :away_team, :class_name => 'Game', :foreign_key => 'away_team_id'
  
  validates :name,
            :presence => true
            
  validates_uniqueness_of :name, :case_sensitive => false
end
