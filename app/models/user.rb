class User < ActiveRecord::Base

  has_many :tracks
  has_many :upvotes
  has_many :reviews

  validates :username, :email, uniqueness: true
  validates :username, :password, :email, :name,
    presence: true

  # def self.signedin?
  #   user = find_by username: username
  #   if user && user.password == password
  #     return true
  #   else
  #     return false
  #   end
  # end

end
