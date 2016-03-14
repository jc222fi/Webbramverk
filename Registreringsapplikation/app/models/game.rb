class Game < ActiveRecord::Base
  has_and_belongs_to_many :tags
  
  belongs_to :end_user
  belongs_to :location

  has_one :home_team, :class_name => 'Team', :foreign_key => 'home_team_id'
  has_one :away_team, :class_name => 'Team', :foreign_key => 'away_team_id'
  
end