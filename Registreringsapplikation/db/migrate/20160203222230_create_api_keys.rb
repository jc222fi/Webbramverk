class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.references :user
      t.string 'app_name'
      t.string 'key'

      t.timestamps null: false
    end
  end
end
