class CreateQuote < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.text :content, :null => false
      t.references :user, :null => false, :default => -1
      t.timestamps
    end
  end
  
  def self.down
    drop_table :quotes
  end
end