class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :username
    end

    create_table :upvotes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :track, index: true
    end

    add_reference :tracks, :user, index: true
  end
end
