class Project < ApplicationRecord
  has_many :tasks , dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  validates :nickname, presence: true
end