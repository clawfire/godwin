class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login, :null => false
      t.string :email, :null => false
      t.string :password_hash, :limit => 64, :null => false
      t.string :password_salt, :limit => 32, :null => false
      t.boolean :priviledged, :null => false, :default => false
      t.timestamps
    end
    # Make "login" UNIQUE.
    add_index :users, :login, :unique => true
    
    create_table :profiles do |t|
      t.belongs_to :user
      t.string :display_name, :null => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :users
    drop_table :profiles
  end
end