FactoryBot.define do
  factory :random_shelter_review, class: ShelterReview do
    title               {Faker::Lorem.sentence}
    rating              {[1,2,3,4,5].sample }
    content             {Faker::Lorem.paragraph}
    sequence(:picture)  {|n| "https://picsum.photos/400/300?image=#{n}"}
    
    association         :shelter, factory: :random_shelter
  end
end