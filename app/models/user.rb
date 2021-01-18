class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :name, presence: true
   has_many :tweets, dependent: :destroy
   has_many :likes, dependent: :destroy
   has_many :likes_posts, through: :like, source: :post

   def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)  
   end

end
