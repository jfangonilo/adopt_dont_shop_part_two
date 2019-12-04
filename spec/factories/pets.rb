FactoryBot.define do
  factory :random_pet, class: Pet do
    sequence(:name)   {|n| "#{Faker::Creature::Cat.name}#{n}"}
    sequence(:image)  {|n| "http://lorempixel.com/400/300/cats/#{n}"}
    approximate_age   {rand(20)}
    sex               {Faker::Gender.binary_type}
    description      {Faker::Movies::StarWars.wookiee_sentence}

    association       :shelter, factory: :random_shelter
  end
end


# sequence(:description)       {|n| "#{Faker::Movies::StarWars.wookiee_sentence}#{n}"}
