class CreateAwayTeams < ActiveRecord::Migration
  def change
    create_table :away_teams do |t|
      t.belongs_to :team, index: true

      t.timestamps null: false
    end
  end
end
