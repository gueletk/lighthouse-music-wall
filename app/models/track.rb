class Track < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes
  validates_presence_of :title, :author

end
