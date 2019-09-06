FactoryBot.define do
  locations = [ "New York", "San Francisco", "Seattle", "Austin", "Paris", "Rome", "Tokyo", "Sydney"]
  factory :location do 
    name { locations.sample }
  end 
end 