class Upvote < ActiveRecord::Base

  belongs_to :user
  belongs_to :track

  def self.exists?(user_id, track_id)
    find_by(user_id: user_id, track_id: track_id) ? true : false
  end

end
