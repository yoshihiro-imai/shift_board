class Tweet < ApplicationRecord
  
with_options presence: true do
  
  validates :title
  validates :context
  validates :user_id

end

belongs_to :user
has_many :likes,  dependent: :destroy
has_many :liked_users, through: :likes, source: :user
has_one_attached :image,  dependent: :destroy
end
