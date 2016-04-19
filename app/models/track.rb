class Track < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes
  has_many :reviews
  validates_presence_of :title, :author

end
