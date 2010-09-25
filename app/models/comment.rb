class Comment < ActiveRecord::Base
  belongs_to :user
  
  # Ensure we're not an orphan
  validates_presence_of :user
  validates_associated :user
end