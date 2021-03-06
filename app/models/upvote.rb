class Upvote < ActiveRecord::Base

  belongs_to :user
  belongs_to :track

  validates :user, :track, presence: true

  def self.exists?(user_id, track_id)
    find_by(user_id: user_id, track_id: track_id) ? true : false
  end

  def self.count(track_id)
    num = where(track_id: track_id).count
    num ? num : 0
  end

end
