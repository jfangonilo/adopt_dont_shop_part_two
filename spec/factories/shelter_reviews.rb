FactoryBot.define do
  factory :random_shelter_review, class: ShelterReview do
    sequence(:title)    {|n| "#{Faker::TvShows::MichaelScott.quote}#{n}"}
    rating              {rand(1..5)}
    sequence(:content)  {|n| "#{Faker::TvShows::TheITCrowd.quote}#{n}"}
    sequence(:picture)  {|n| "https://picsum.photos/400/300?image=#{n}"}

    association         :shelter, factory: :random_shelter
  end
end
