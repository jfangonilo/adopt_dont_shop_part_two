FactoryBot.define do
  factory :random_shelter, class: Shelter do
    sequence(:name)    {|n| "#{Faker::TvShows::GameOfThrones.city}#{n}"}
    sequence(:address) {|n| "#{Faker::Address.street_address}#{n}"}
    sequence(:city)    {|n| "#{Faker::Address.city}#{n}"}
    state   {Faker::Address.state}
    zip     {Faker::Address.zip}
  end
end
