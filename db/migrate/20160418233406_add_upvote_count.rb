class AddUpvoteCount < ActiveRecord::Migration
  def change
    add_column :tracks, :upvote_count, :integer
  end
end
