class Rating < ActiveRecord::Base
  belongs_to :user
  
  # Ensuire we're not an orphan
  validates_presence_of :user
  validates_associated :user
end