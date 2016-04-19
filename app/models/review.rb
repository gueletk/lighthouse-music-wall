class Review < ActiveRecord::Base

  validates_presence_of :user_id, :track_id, :rating

end
