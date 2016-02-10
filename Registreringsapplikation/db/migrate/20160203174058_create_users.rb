class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string 'email', :default => "", :null => false
      t.string 'role', :limit => 10, :default => 'user'
      t.string 'password_digest', :null=> false

      t.timestamps null: false
    end
  end
end
