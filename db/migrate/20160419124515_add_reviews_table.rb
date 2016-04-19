class AddReviewsTable < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.belongs_to :track
      t.integer :rating
      t.string :content
    end
  end
end
