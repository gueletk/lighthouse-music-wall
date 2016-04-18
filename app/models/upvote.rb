class Upvote < ActiveRecord::Base

  belongs_to :user
  belongs_to :track

  def self.exists?(user_id, track_id)
    find_by(user_id: user_id, track_id: track_id) ? true : false
  end

  def self.count(track_id)
    where(track_id: track_id).count
  end

end
