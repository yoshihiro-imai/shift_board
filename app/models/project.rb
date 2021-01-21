class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  validates_inclusion_of :month, presence: true ,in:1..12,message: "は１〜１２の数値を入力してください "
end
