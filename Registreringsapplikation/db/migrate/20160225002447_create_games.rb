class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|

      t.integer 'home_score'
      t.integer 'away_score'

      t.belongs_to :end_user, index: true
      t.belongs_to :location, index: true
      
      t.references :home_team, index: true
      t.references :away_team, index: true

      t.timestamps null: false
    end
  end
end