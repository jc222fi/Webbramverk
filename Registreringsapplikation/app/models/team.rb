class Team < ActiveRecord::Base
  belongs_to :away_team
  belongs_to :home_team


end
