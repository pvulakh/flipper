FactoryBot.define do 
  factory :user do 
    username { Faker::Twitter.screen_name }
    password { "starwars" }
    location { create(:location) }
  end 
end 