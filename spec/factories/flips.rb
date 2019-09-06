FactoryBot.define do 
  factory :flip do 
    body { Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote }
    association :author, factory: :user
  end 
end 