require 'rails_helper'

RSpec.describe "When a user visits a pet's show page" do
  before :each do
    @shelter = create(:random_shelter)
    @pet_1 = create(:random_pet, shelter: @shelter)
    @pet_2 = create(:random_pet, shelter: @shelter)
  end

  xit "can add the pet to their favorites" do
    visit "/pets/#{@pet_1.id}"
    click_button "Add to Favorites"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} has been added to your favorites!")

    within ".topnav" do
      expect(page).to have_content("1 Favorite")
    end

    visit "/pets/#{@pet_2.id}"
    click_button "Add to Favorites"

    expect(current_path).to eq("/pets/#{@pet_2.id}")
    expect(page).to have_content("#{@pet_2.name} has been added to your favorites!")

    within ".topnav" do
      expect(page).to have_content("2 Favorites")
    end
  end
end
