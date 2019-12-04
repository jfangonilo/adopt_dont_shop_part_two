require 'rails_helper'

RSpec.describe "When a user visits a pet's show page" do
  before :each do
    @shelter = create(:random_shelter)
    @pet_1 = create(:random_pet, shelter: @shelter)
    @pet_2 = create(:random_pet, shelter: @shelter)
  end

  it "can add the pet to their favorites" do
    visit "/pets/#{@pet_1.id}"
    within "#pet-#{@pet_1.id}" do
      click_button "Add to Favorites"
    end

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} has been added to your favorites! You have 1 pet in your favorites.")

    visit "/pets/#{@pet_2.id}"
    within "#pet-#{@pet_2.id}" do
      click_button "Add to Favorites"
    end

    expect(current_path).to eq("/pets/#{@pet_2.id}")
    expect(page).to have_content("#{@pet_2.name} has been added to your favorites! You have 2 pets in your favorites.")
  end

end
