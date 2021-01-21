class Task < ApplicationRecord
  belongs_to :project
  validates :date, presence: true
  validates :intime, presence: true
  validates :outtime, presence: true

end
