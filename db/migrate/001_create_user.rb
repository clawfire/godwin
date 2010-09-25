class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login, :null => false
      t.string :password_hash, :limit => 64, :null => false
      t.string :password_salt, :limit => 32, :null => false
      t.boolean :priviledged, :null => false, :default => false
      t.timestamps
    end
    # Make "login" UNIQUE.
    add_index :users, :login, :unique => true
  end
  
  def self.down
    drop_table :users
  end
end