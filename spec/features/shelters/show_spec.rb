require 'rails_helper'

describe "As a visitor, when I visit /shelters/:id," do
  before :each do
    @shelter_1 = Shelter.create!(
      name:     "Shelter 1",
      address:  "6303 W Exposition Ave",
      city:     "Lakewood",
      state:    "CO",
      zip:      "80226"
    )

    @pet = @shelter_1.pets.create(
      image:            "https://www.allthingsdogs.com/wp-content/uploads/2018/12/Husky-Names-Feature.jpg",
      name:             "Seamus",
      approximate_age:  8,
      sex:              "male",
      description:      "Winter is Coming; dog"
    )

      visit "shelters/#{@shelter_1.id}"
  end

  it "I can see the shelter with that id including the shelter's name, address, city, state, zip" do
    expect(page).to have_content "Shelter 1"
    expect(page).to have_content "6303 W Exposition Ave"
    expect(page).to have_content "Lakewood"
    expect(page).to have_content "CO"
    expect(page).to have_content "80226"
  end

  it "I can navigate to the edit shelter page via an Update link" do
    click_link "Update"
    expect(current_path).to eq "/shelters/#{@shelter_1.id}/edit"
  end

  it "I can delete the shelter and redirect to index via a link" do
    click_link "Delete"
    expect(current_path).to eq "/shelters"
    expect(page).to_not have_content "Shelter 1"
    expect(page).to_not have_content "6303 W Exposition Ave"
    expect(page).to_not have_content "Lakewood"
    expect(page).to_not have_content "CO"
    expect(page).to_not have_content "80226"
  end

  it "I can navigate to the pet index for that shelter" do
    click_link "#{@shelter_1.name}"
    expect(current_path).to eq "/shelters/#{@shelter_1.id}/pets"
  end

  it "I can see all shelter reviews and their traits" do
    @reviews  = create_list(:random_shelter_review, 3, shelter: @shelter_1)

    visit "/shelters/#{@shelter_1.id}"

    @reviews.each do |review|
      within "#review-#{review.id}" do
        expect(page).to have_content review.title
        expect(page).to have_content review.rating
        expect(page).to have_content review.content
        expect(page).to have_css "img[src = '#{review.picture}']"
      end
    end
  end

end
