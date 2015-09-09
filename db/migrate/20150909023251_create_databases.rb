class CreateDatabases < ActiveRecord::Migration
  def change
    create_table :databases do |t|
      t.string :name
      t.string :database
      t.string :adapter
      t.string :host
      t.string :port
      t.string :encrypted_username
      t.string :encrypted_password

      t.timestamps null: false
    end
  end
end
