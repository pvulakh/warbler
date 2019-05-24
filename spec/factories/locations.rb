FactoryBot.define do
  places = ['NYC', 'Toronto', 'Alabama', 'Amsterdam', 'Paris', 'Tel Aviv']
  factory :location do
    name { places.sample }
  end
end