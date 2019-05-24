
FactoryBot.define do
  factory :user do
    # Faker is a gem that we included.
    name { Faker::Movies::StarWars.character } 
    password { "starwars" }
    location { create(:location) } 
    # create will look for a location factory, 
    # and return the location
  end
end