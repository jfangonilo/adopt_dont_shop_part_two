FactoryBot.define do
  factory :random_pet, class: Pet do
    sequence(:name)           {|n| "#{Faker::Creature::Cat.name}#{n}"}
    sequence(:image)          {|n| "http://lorempixel.com/400/300/cats/#{n}"}
    approximate_age           {rand(1..20)}
    sex                       {Faker::Gender.binary_type}
    sequence(:description)    {|n| "#{Faker::Movies::StarWars.wookiee_sentence}#{n}"}

    association       :shelter, factory: :random_shelter
  end
end
