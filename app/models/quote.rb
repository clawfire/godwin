class Quote < ActiveRecord::Base
  # belongs_to :user # Can this be optional?
  has_many :comments
  has_many :ratings
end