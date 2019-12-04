FactoryBot.define do
  factory :random_pet, class: Pet do
    name              {Faker::Creature::Cat.name}
    sequence(:image)  {|n| "http://lorempixel.com/400/300/cats/#{n}"}
    approximate_age   {rand(20)}
    sex               {Faker::Gender.binary_type}
    description       {Faker::Movies::StarWars.wookiee_sentence}

    association       :shelter, factory: :random_shelter
  end
end