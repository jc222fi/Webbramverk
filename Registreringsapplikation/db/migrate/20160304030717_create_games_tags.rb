class CreateGamesTags < ActiveRecord::Migration
  def change
    create_table :games_tags do |t|
      t.integer "game_id"
      t.integer "tag_id"
    end
    
    add_index :games_tags, ["game_id", "tag_id"], :unique => true
  end
end
