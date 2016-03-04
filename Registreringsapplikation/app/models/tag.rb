class Tag < ActiveRecord::Base
  has_and_belongs_to_many :games
  validates :name,
            :presence => true
            
  validates_uniqueness_of :name, :case_sensitive => false
end
