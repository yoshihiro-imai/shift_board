FactoryBot.define do
  factory :task do
    date { "2021-01-21" }
    intime { 1 }
    outtime { 1 }
    project { nil }
  end
end
