FactoryBot.define do
  factory :project do
    nickname {Faker::Name.last_name}
    association :user

  end
end