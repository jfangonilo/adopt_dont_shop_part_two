require 'rails_helper'

describe "As a user, when I visit the /shelters/:shelter_id/pets page," do
  before :each do
    @shelter_1 = create(:random_shelter)
    @pet_2 = create(:random_pet, shelter: @shelter_1)
    @pet_1 = create(:random_pet, shelter: @shelter_1)

    visit "/shelters/#{@shelter_1.id}/pets"
  end

  it "I can see each pet that can be adopted from that shelter" do
    within "#pet-#{@pet_1.id}" do
      expect(page).to have_css "img[src = '#{@pet_1.image}']"
      expect(page).to have_content @pet_1.name
      expect(page).to have_content @pet_1.approximate_age
      expect(page).to have_content @pet_1.sex
    end

    within "#pet-#{@pet_2.id}" do
      expect(page).to have_css "img[src = '#{@pet_2.image}']"
      expect(page).to have_content @pet_2.name
      expect(page).to have_content @pet_2.approximate_age
      expect(page).to have_content @pet_2.sex
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
    within "#pet-count" do
      expect(page).to have_content "2 Pets"
    end
  end
end
