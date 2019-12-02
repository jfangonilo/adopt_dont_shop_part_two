require 'rails_helper'

describe "As a user, when I visit the /shelters/:shelter_id/pets page," do
  before :each do
    @shelter_1 = Shelter.create!(
      name:     "Winterfell",
      address:  "6303 W Exposition Ave",
      city:     "Lakewood",
      state:    "CO",
      zip:      "80226"
    )

    @pet_1 = @shelter_1.pets.create!(
      image:            "https://www.allthingsdogs.com/wp-content/uploads/2018/12/Husky-Names-Feature.jpg",
      name:             "Seamus",
      approximate_age:  8,
      sex:              "male",
      description:      "Winter is Coming; dog"
    )
    @pet_2 = @shelter_1.pets.create!(
      image:            "https://www.catster.com/wp-content/uploads/2018/03/Calico-cat.jpg",
      name:             "Miso",
      approximate_age:  2,
      sex:              "female",
      description:      "Winter is Coming; cat"
    )

    visit "/shelters/#{@shelter_1.id}/pets"
  end

  it "I can see each pet that can be adopted from that shelter" do
    within "#pet-#{@pet_1.id}" do
      expect(page).to have_css "img[src *= 'Husky-Names-Feature.jpg']"
      expect(page).to have_content "Seamus"
      expect(page).to have_content 8
      expect(page).to have_content "male"
    end

    within "#pet-#{@pet_2.id}" do
      expect(page).to have_css "img[src *= 'Calico-cat.jpg']"
      expect(page).to have_content "Miso"
      expect(page).to have_content 2
      expect(page).to have_content "female"
    end
  end

  it "I can add an adoptable pet to that shelter via a link" do
    click_link "Add Pet"

    expect(current_path).to eq "/shelters/#{@shelter_1.id}/pets/new"
  end

  it "can navigate to a pet on the page" do
    within "#pet-#{@pet_1.id}" do
      click_link "#{@pet_1.name}"
    end
    expect(current_path).to eq "/pets/#{@pet_1.id}"
  end

  it "I can see a count of pets at the shelter" do
    expect(page).to have_content "2 Pets at Winterfell"
  end
end
