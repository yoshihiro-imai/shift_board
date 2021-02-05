FactoryBot.define do
  factory :tweet do
    title {Faker::Lorem.sentence}
    context {Faker::Lorem.sentence}
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/image.png'), filename: 'image.png')
    end 
    
  end
end