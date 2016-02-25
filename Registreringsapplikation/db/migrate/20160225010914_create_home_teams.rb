class CreateHomeTeams < ActiveRecord::Migration
  def change
    create_table :home_teams do |t|
      t.belongs_to :team, index: true

      t.timestamps null: false
    end
  end
end
