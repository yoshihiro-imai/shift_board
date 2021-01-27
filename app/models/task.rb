class Task < ApplicationRecord
  belongs_to :project
  with_options presence:true do
    validates :intime
    validates :outtime
  end
end
