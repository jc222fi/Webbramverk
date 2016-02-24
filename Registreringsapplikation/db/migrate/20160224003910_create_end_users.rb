class CreateEndUsers < ActiveRecord::Migration
  def change
    create_table :end_users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :token
      t.string :auth_token
      t.datetime :token_expires

      t.timestamps null: false
    end
  end
end
