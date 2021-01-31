FactoryBot.define do
  factory :task do
    start_time { "2021-01-31 18:57:00" }
    intime { "2021-01-31 18:57:00" }
    outtime { "2021-01-31 19:57:00" }
    association :project

  end
end
