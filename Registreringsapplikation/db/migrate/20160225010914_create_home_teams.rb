class CreateHomeTeams < ActiveRecord::Migration
  def change
    create_table :home_teams do |t|
      t.string 'name', :limit => 40, :null => false

      t.timestamps null: false
    end
  end
end
