class Task < ApplicationRecord
  belongs_to :project
  with_options presence:true do
    validates :start_time,uniqueness:{ scope: :project_id}
    validates :intime
    validates :outtime
  end
  validate :start_end_check

  def start_end_check
    if self.intime != nil && self.outtime != nil
    errors.add(:outtime, "の日付を正しく記入してください。") unless
    self.intime < self.outtime
    end
  
end
end