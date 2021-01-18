FactoryBot.define do
  factory :tweet do
    title {Faker::Lorem.sentence}
    context {Faker::Lorem.sentence}
    association :user
  end
end