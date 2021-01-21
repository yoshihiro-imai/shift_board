class Task < ApplicationRecord
  belongs_to :project
  with_options presence:true do
    validates_inclusion_of :date,in:1..31,message: "は1〜31の数値を入力してください "
    validates_inclusion_of :intime,in:1..24,message: "は1〜24の数値を入力してください "
    validates_inclusion_of :outtime,in:1..24,message: "は1〜24の数値を入力してください "
  end
end
