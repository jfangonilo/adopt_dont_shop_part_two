FactoryBot.define do
  factory :random_pet, class: Pet do
    name {Faker::FunnyName.name}
    sequence(:image) { |n| "http://lorempixel.com/400/300/cats/#{n}" }
    approximate_age {[1,2,3,4,5,6,7,8,9,10].sample}
    sex {Faker::Gender.binary_type}
    description {Faker::Movies::StarWars.wookiee_sentence}
    association :shelter, factory: :random_shelter
  end
end