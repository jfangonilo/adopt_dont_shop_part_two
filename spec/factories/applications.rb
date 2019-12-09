FactoryBot.define do
  factory :application do
    sequence(:name) {|n| "#{Faker::FunnyName.name}#{n}"}
    address         {Faker::Address.street_address}
    city            {Faker::Address.city}
    state           {Faker::Address.state}
    zip             {Faker::Address.zip}
    phone_number    {Faker::PhoneNumber.phone_number}
    description     {Faker::TvShows::HeyArnold.quote}
  end
end