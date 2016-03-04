class Game < ActiveRecord::Base
  has_and_belongs_to_many :tags
  
  belongs_to :end_user
  belongs_to :location

  belongs_to :home_team
  belongs_to :away_team
end