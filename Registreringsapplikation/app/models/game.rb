class Game < ActiveRecord::Base
  belongs_to :end_user
  belongs_to :location

  belongs_to :home_team
  belongs_to :away_team

  #has_one :away_team
  #has_one :home_team
end
