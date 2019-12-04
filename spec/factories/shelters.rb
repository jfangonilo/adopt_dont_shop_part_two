FactoryBot.define do
  factory :random_shelter, class: Shelter do
    name    {Faker::TvShows::GameOfThrones.city}
    address {Faker::Address.street_address}
    city    {Faker::Address.city}
    state   {Faker::Address.state}
    zip     {Faker::Address.zip}
  end
end