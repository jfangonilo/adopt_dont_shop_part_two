FactoryBot.define do
  factory :random_shelter, class: Shelter do
    sequence(:name)    {|n| "#{Faker::TvShows::GameOfThrones.city}#{n}"}
    sequence(:address) {|n| "#{Faker::Address.street_address}#{n}"}
    city    {Faker::Address.city}
    state   {Faker::Address.state}
    zip     {Faker::Address.zip}
  end
end
