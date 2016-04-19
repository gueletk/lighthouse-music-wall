class Review < ActiveRecord::Base

  validates_presence_of :user_id, :track_id, :rating

  def self.exists?(user_id, track_id)
    find_by(user_id: user_id, track_id: track_id) ? true : false
  end

end
