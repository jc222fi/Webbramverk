class Team < ActiveRecord::Base
  belongs_to :away_team
  belongs_to :home_team
  
  validates :name,
            :presence => true
            
  validates_uniqueness_of :name, :case_sensitive => false
end
