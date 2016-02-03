class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string 'name', :limit => 20
      t.string 'email', :default => "", :null => false
      t.string 'role', :limit => 10
      t.string 'username', :limit =>20, :null => false
      t.string 'password', :null => false

      t.timestamps null: false
    end
  end
end
