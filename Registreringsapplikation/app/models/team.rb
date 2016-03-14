class Team < ActiveRecord::Base
  #belongs_to :away_team
  #belongs_to :home_team
  
  belongs_to :home_team, :class_name => 'Team' # Added by gammelsmurf
  belongs_to :away_team, :class_name => 'Team' # Added by the only smurfan
  
  validates :name,
            :presence => true
            
  validates_uniqueness_of :name, :case_sensitive => false
end
