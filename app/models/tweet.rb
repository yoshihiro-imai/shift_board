class Tweet < ApplicationRecord
  
with_options presence: true do
  
  validates :title
  validates :context
  validates :user_id

end

belongs_to :user
has_many :likes
has_many :liked_users, through: :likes, source: :user
end
